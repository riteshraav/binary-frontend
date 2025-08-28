import 'package:flutter/material.dart';

class ExcelViewerScreen extends StatelessWidget {
  final String title;
  final List<List<dynamic>> data;

  const ExcelViewerScreen({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: data.isEmpty
          ? const Center(child: Text('No data to display'))
          : Center(
        child: SizedBox(
          width: screenWidth * 0.95, // 95% of screen width
          height: screenHeight * 0.8, // 80% of screen height
          child: Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: screenWidth * 0.95),
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columnSpacing: 16,
                      dataRowHeight: 40,
                      headingRowHeight: 40,
                      columns: data.first
                          .map((e) => DataColumn(
                        label: Text(
                          e.toString(),
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ))
                          .toList(),
                      rows: data.skip(1).map(
                            (row) {
                          return DataRow(
                            cells: row
                                .map((cell) => DataCell(
                                Text(cell.toString(),
                                    style: const TextStyle(fontSize: 14))))
                                .toList(),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
