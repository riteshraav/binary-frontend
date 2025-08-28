import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/buffalo_ratechart_provider.dart';
import '../providers/cow_rate_chart_provider.dart';
import 'excel_viewer_screen.dart';

class RateMasterScreen extends StatefulWidget {
  const RateMasterScreen({super.key});

  @override
  State<RateMasterScreen> createState() => _RateMasterScreenState();
}

class _RateMasterScreenState extends State<RateMasterScreen> {
  String animal = 'Buffalo';

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await context.read<CowRateChartProvider>().loadFromPrefs();
      await context.read<BuffaloRatechartProvider>().loadFromPrefs();
      setState(() {});
    });
  }

  Future<void> _pickExcel() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
      withData: true,
    );
    if (result == null) return;

    final bytes = result.files.single.bytes ??
        await File(result.files.single.path!).readAsBytes();

    if (animal == 'Cow') {
      await context.read<CowRateChartProvider>().loadFromExcelBytes(bytes);
    } else {
      await context.read<BuffaloRatechartProvider>().loadFromExcelBytes(bytes);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$animal rate chart uploaded')),
      );
      setState(() {});
    }
  }

  void _openExcelViewer(BuildContext context, String title, List<List<dynamic>> data) {
    if (data.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No data to display')),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ExcelViewerScreen(title: title, data: data),
      ),
    );
  }

  Widget _buildStatus(
      String title,
      bool ready,
      List<double> fat,
      List<double> snf,
      VoidCallback onView,
      ) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(
          ready
              ? 'Loaded ✓  FAT: ${fat.isNotEmpty ? '${fat.first}–${fat.last}' : '-'} | '
              'SNF: ${snf.isNotEmpty ? '${snf.first}–${snf.last}' : '-'}'
              : 'Not loaded',
        ),
        trailing: ready
            ? Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.visibility),
              tooltip: 'View Excel',
              onPressed: onView,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Clear',
              onPressed: () {
                if (title.contains('Cow')) {
                  context.read<CowRateChartProvider>().clearChart();
                } else {
                  context.read<BuffaloRatechartProvider>().clearChart();
                }
                if (mounted) setState(() {});
              },
            ),
          ],
        )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cow = context.watch<CowRateChartProvider>();
    final buffalo = context.watch<BuffaloRatechartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Rate Master')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Animal:'),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: animal,
                  items: const [
                    DropdownMenuItem(value: 'Buffalo', child: Text('Buffalo')),
                    DropdownMenuItem(value: 'Cow', child: Text('Cow')),
                  ],
                  onChanged: (v) => setState(() => animal = v!),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: _pickExcel,
                  icon: const Icon(Icons.upload_file),
                  label: const Text('Upload Excel'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildStatus(
              'Buffalo Chart',
              buffalo.filePicked,
              buffalo.fatValues,
              buffalo.snfValues,
                  () => _openExcelViewer(context, 'Buffalo Rate Chart', buffalo.tableData),
            ),
            _buildStatus(
              'Cow Chart',
              cow.filePicked,
              cow.fatValues,
              cow.snfValues,
                  () => _openExcelViewer(context, 'Cow Rate Chart', cow.tableData),
            ),
            const SizedBox(height: 12),
            const Text(
              'Note: First column must be FAT. Header row must be SNF.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
