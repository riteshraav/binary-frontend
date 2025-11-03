import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:file_selector/file_selector.dart';
import 'package:oktoast/oktoast.dart';
import 'package:windows_sample/model/rate_model.dart';

class RateChartService extends ChangeNotifier {
  List<List<String>> excelData = [];
  bool filePicked = false;
  int? row;
  int? col;
  String name = "";
  double? minimumFat ;
  double? minimumSNF ;
  double? minimumRate;
  double? maximumFat;
  double? maximumSNF;
  double? maximumRate;
  double localMilkSale=0;
  double _morningQuantity = 0;
  String? filePath = "";

  double get morningQuantity => _morningQuantity;

  set morningQuantity(double value) {
    _morningQuantity = value;
    String admin = "1";
    print('opening cowbox');

  }

  double _eveningQuantity = 0;
  // Constructor
  RateChartService({
    this.row,
    this.col,
    this.name = "",
    this.minimumFat,
    this.minimumSNF,
    this.minimumRate,
    this.maximumFat,
    this.maximumSNF,
    this.maximumRate,
    this.localMilkSale = 0,
    this.filePath
  });
  void setValues(
      var minimumFat,
      var minimumSNF,
      var minimumRate,
      var maximumFat,
      var maximumSNF,
      var maximumRate,
      )async
  {
    String admin= "1";
    this.minimumFat = minimumFat;
    this.minimumSNF = minimumSNF;
    this.minimumRate = minimumRate;
    this.maximumFat = maximumFat;
    this.maximumSNF=maximumSNF;
    this.maximumRate=maximumRate;

    notifyListeners();
  }
  List<dynamic> getCowValues()
  {
    List<dynamic> list = [];
    list.add(minimumFat ?? "");
    list.add(minimumSNF?? "");
    list.add(minimumRate?? "");
    list.add(maximumFat?? "");
    list.add(maximumSNF?? "");
    list.add(maximumRate?? "");
    return list;
  }

  void clearAllData() {
    print("Clearing all CowRateChartProvider data...");

    excelData = [];
    filePicked = false;

    row = null;
    col = null;

    name = "";

    minimumFat = null;
    minimumSNF = null;
    minimumRate = null;

    maximumFat = null;
    maximumSNF = null;
    maximumRate = null;

    localMilkSale = 0;
    notifyListeners();
    print("CowRateChartProvider data cleared.");
  }
  void updateExcelData(List<List<String>> updatedExcelData,int row, int col)async{
    excelData = updatedExcelData.map((row) => List<String>.from(row)).toList();

    print("notified all about update of the exceldata");


    notifyListeners();
  }



  Future<Map<String,dynamic>?> pickExcelFile(bool isCow) async {
    try {
      // Restrict to only Excel files
      const XTypeGroup typeGroup = XTypeGroup(
        label: 'Excel',
        extensions: ['xlsx', 'xls'],
      );

      // Open modal dialog (blocks clicks on Flutter app)
      final XFile? file =
      await openFile(acceptedTypeGroups: [typeGroup]);

      if (file == null) {
        print("❌ No file selected");
        return null;
      }

      // Get file path + name
      filePath = file.path;
      final String fileName = file.name;
      print("📂 Picked file: $filePath");

      // Read file bytes
      Uint8List bytes = await file.readAsBytes();

      // Decode Excel
      var excel = Excel.decodeBytes(bytes);
      this.excelData = [];

      for (var sheetName in excel.tables.keys) {
        var sheet = excel.tables[sheetName];
        if (sheet != null) {
          for (var row in sheet.rows) {
            this.excelData.add(
              row.map((cell) => cell?.value?.toString() ?? '').toList(),
            );
          }
        }
      }

      print('✅ Excel decoded successfully');
      bool isCowFile = searchValue("2.00",isCow);
      if (isCow ) {
        if(isCowFile) {
          print('Row is $row Col is $col');
          findExtremeValuesForCow();
          filePicked = true;
        }
        else{
          print('cow file is not valid');
          showToast(
            "Wrong file uploaded. Could not detect Cow",
            backgroundColor: Colors.redAccent,
            position: ToastPosition.top,
            textStyle: const TextStyle(fontSize: 16, color: Colors.white),
            duration: const Duration(seconds: 3),
          );
          minimumSNF = 0;
          minimumFat = 0;
          minimumRate = 0;
          maximumFat = 0;
          maximumSNF =  0;
          maximumRate = 0;
          filePicked = false;
        }
      }
      else{
        if(!isCowFile && searchValue("3.00",isCow)){
          print('Row is $row Col is $col');
          findExtremeValuesForBuffalo();
          filePicked = true;
        }
        else{
          showToast(
            "Wrong file uploaded. Could not detect Buffalo",
            backgroundColor: Colors.redAccent,
            position: ToastPosition.top,
            textStyle: const TextStyle(fontSize: 16, color: Colors.white),
            duration: const Duration(seconds: 3),
          );
          print('buffalo file is not valid');
          minimumSNF = 0;
          minimumFat = 0;
          minimumRate = 0;
          maximumFat = 0;
          maximumSNF =  0;
          maximumRate = 0;
          filePicked = false;
        }
      }
      print("📢 Notified all about picked Excel");
      notifyListeners();
      Map<String,dynamic> excelData= {};
      excelData["row"]=row;
      excelData["col"]=col;
      excelData['isFilePicked'] = filePicked;
      excelData["filePath"]=filePath;
      excelData["fileName"] = fileName;
      excelData["excelData"]=this.excelData;
      excelData['minimumFat'] = minimumFat;
      excelData['minimumSNF'] = minimumSNF;
      excelData['minimumRate'] = minimumRate;
      excelData['maximumFat'] = maximumFat;
      excelData['maximumSNF'] = maximumSNF;
      print('maximum rate is ${maximumRate}');
      excelData['maximumRate'] = maximumRate;
      return excelData;
    } catch (e, st) {
      print("⚠️ Error picking Excel file: $e");
      print(st);
      return null;
    }
  }

  /// Function to search for the first occurrence of 2.00
  bool searchValue(String searchValue,bool isCow) {
    for (int rowIndex = 0; rowIndex < excelData.length; rowIndex++) {
      for (int colIndex = 0; colIndex < excelData[rowIndex].length; colIndex++) {
        if (excelData[rowIndex][colIndex] == searchValue) {
          {
            row = rowIndex;
            col = colIndex;
            return true;
          }

        }
      }
    }
    if(isCow)
    showToast(
      "Wrong file uploaded. Could not detect $searchValue",
      backgroundColor: Colors.redAccent,
      position: ToastPosition.top,
      textStyle: const TextStyle(fontSize: 16, color: Colors.white),
      duration: const Duration(seconds: 3),
    );
    print("$searchValue not found in cow rate chart");
    return false;
  }
  void findExtremeValuesForCow() {
    minimumSNF = 7.5;
    minimumFat = 2;
    minimumRate = double.parse(excelData[row!][col! + 1]);
    maximumFat = 5;
    maximumSNF =  9;
    maximumRate = double.parse(excelData[row! + 30][col! + 16]);

  }
  void findExtremeValuesForBuffalo() {
    print('extereme values for buffalow called');
    minimumSNF = 8;
    minimumFat = 3;
    print(excelData[row!][col! + 1]);
    minimumRate = double.parse(excelData[row!][col! + 1]);
    maximumFat = 14.9;
    maximumSNF =  10;
    print('extremet value is ${excelData[row! + 119][col! + 21]}');
    maximumRate = double.parse(excelData[row! + 119][col! + 21]);

  }
  double findRateForCow(RateModel rateModel, List<List<String>> excelData,double fat, double snf) {
    // Case 1: Minimum bounds check (only if both minimum values are provided
    if (fat < rateModel.minFat || snf < rateModel.minsnf){
      return rateModel.minRate;
    }

    // Case 2: Maximum bounds check (only if both maximum values are provided)
    else if (fat > rateModel.maxFat || snf > rateModel.maxsnf) {
      return rateModel.maxRate;
    }
    // Case 3: Default calculation
    else {
      print("row = ${rateModel.row} fat = $fat  col = ${rateModel.col}  snf = $snf");

      int excelRow = rateModel.row + ((fat - 2) * 10).round();
      int excelCol = 1 + rateModel.col + ((snf - 7.5) * 10).round();

      print("excel row $excelRow  excel col $excelCol");
      print("snf is ${excelData[excelRow][rateModel.col]}");
      print("fat is ${excelData[rateModel.row][excelCol]}");

      return double.parse(excelData[excelRow][excelCol]);
    }
  }

  double findRateForBuffalo(RateModel rateModel,  List<List<String>> excelData,  double fat, double snf) {
    // Case 1: Minimum bounds check
    if (fat < rateModel.minFat || snf < rateModel.minsnf) {
      if( fat < rateModel.minFat ) {
        print('minimum rate called coz of fat');
      } else{
        print('snf is $snf  min snf is ${rateModel.minsnf}' );
        print('minimum rate called coz of snf');

      }
      return rateModel.minRate;
    }

    // Case 2: Maximum bounds check
    else if (fat > rateModel.maxFat || snf > rateModel.maxsnf ) {
      return rateModel.maxRate;
    }

    // Case 3: Default when no bounds or within range
    else {  
      print("row = ${rateModel.row} fat = $fat  col = ${rateModel.col}  snf = $snf");

      int excelRow = rateModel.row + ((fat - 3) * 10).round();
      int excelCol = 1 + rateModel.col + ((snf - 8) * 10).round();

      print("excel row $excelRow  excel col $excelCol");
      print("snf is ${excelData[excelRow][rateModel.col]}");
      print("fat is ${excelData[rateModel.row][excelCol]}");

      return double.parse(excelData[excelRow][excelCol]);
    }
  }


  double get eveningQuantity => _eveningQuantity;

  set eveningQuantity(double value) {
    _eveningQuantity = value;
    notifyListeners();
  }
}
