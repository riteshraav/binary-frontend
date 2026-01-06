import 'package:flutter/material.dart';

class RateExcelViewPage extends StatelessWidget {
  final List<List<dynamic>> rows;
  final String type;

  const RateExcelViewPage({super.key, required this.rows, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$type Rates")),
      body: rows.isEmpty
          ? const Center(child: Text("No data available"))
          : Padding(
        padding: const EdgeInsets.all(12.0),
        child: Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: DataTable(
                  headingRowColor: MaterialStateProperty.resolveWith((_) => const Color(0xFFEFF6FF)),
                  columns: const [
                    DataColumn(label: Text("Fat")),
                    DataColumn(label: Text("SNF")),
                    DataColumn(label: Text("Rate")),
                  ],
                  rows: rows
                      .map((r) => DataRow(cells: [
                    DataCell(Text(r[0].toString())),
                    DataCell(Text(r[1].toString())),
                    DataCell(Text(r[2].toString())),
                  ]))
                      .toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
