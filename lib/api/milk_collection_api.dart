import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:windows_sample/model/milk_collection_model.dart';

class MilkCollectionApi{
  Future<void> saveMilkCollection(MilkCollectionModel model) async {
    final url = Uri.parse("https://backend-dairy-nefj.onrender.com/api/milk/save");
    return;

    try{
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200) {
        print("Saved successfully: ${response.body}");
      } else {
        print("Error: ${response.statusCode}");
      }
    }
    catch (e){
      print('Excepton in milk api : $e');
    }
  }
}