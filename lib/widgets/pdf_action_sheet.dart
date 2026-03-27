import 'package:flutter/material.dart';
import '../models/report_data.dart';
import '../services/pdf_report_service.dart';
import '../screens/pdf_preview_screen.dart';

class PdfActionSheet extends StatelessWidget {
  final ReportData reportData;

  const PdfActionSheet({super.key, required this.reportData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.picture_as_pdf, color: Colors.blue),
            title: const Text('Preview PDF'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PdfPreviewScreen(reportData: reportData),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.share, color: Colors.green),
            title: const Text('Share PDF'),
            onTap: () async {
              Navigator.pop(context);
              final bytes = await PdfReportService.generateReport(reportData);
              await PdfReportService.sharePdf(bytes, reportData.generatedAt);
            },
          ),
        ],
      ),
    );
  }
}
