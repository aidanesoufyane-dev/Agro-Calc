import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import '../models/report_data.dart';
import '../services/pdf_report_service.dart';

class PdfPreviewScreen extends StatelessWidget {
  final ReportData reportData;

  const PdfPreviewScreen({super.key, required this.reportData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              final bytes = await PdfReportService.generateReport(reportData);
              await PdfReportService.sharePdf(bytes, reportData.generatedAt);
            },
          ),
        ],
      ),
      body: PdfPreview(
        build: (format) => PdfReportService.generateReport(reportData),
        allowSharing: true,
        allowPrinting: true,
      ),
    );
  }
}
