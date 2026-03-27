import 'package:npk2/services/pdf_report_service.dart';
import 'package:npk2/models/report_data.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:intl/date_symbol_data_local.dart';
void main() async {
  await initializeDateFormatting('fr_FR', null);
  testWidgets('PDF generation', (tester) async {
    try {
      final data = ReportData(
        mkpA17: 0,
        npA5: 0,
        spA6: 0,
        calA7: 0,
        acidA8: 0,
        aphA9: 0,
        ammonA10: 0,
        mapA11: 0,
        ureeA15: 0,
        ACIDSULB18: 0,
        nmgoA16: 0,
        sulamoA14: 0,
        chlorA12: 0,
        smgoA13: 0,
        eeiM24: 0,
        supB31: 0,
        sfF3: 0,
        smlM21: 0,
        no3: 0,
        nh4: 0,
        h2po4: 0,
        k: 0,
        so42: 0,
        ca: 0,
        h: 0,
        clk: 0,
        mg2: 0,
        qgl: 0,
        ecf: 0,
        con: 0,
        unitN: 0,
        unitP: 0,
        unitK2O: 0,
        unitCaO: 0,
        unitMgO: 0,
        eqN: 0,
        eqP: 0,
        eqK: 0,
        eqCa: 0,
        eqMg: 0,
        nHa: 0,
        pHa: 0,
        kHa: 0,
        caHa: 0,
        mgHa: 0,
        pNO3: 0,
        pNH4: 0,
        generatedAt: DateTime.now(),
      );
      await PdfReportService.generateReport(data);
      print('SUCCESS PDF GENERATED WITHOUT NULL ERRORS');
    } catch (e, s) {
      print('PDF GENERATION FAILED');
      print(e);
      print(s);
      rethrow;
    }
  });
}
