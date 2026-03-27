import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/calcule_model.dart';
import '../models/report_data.dart';
import '../models/bac_item.dart';
import '../widgets/pdf_action_sheet.dart';
import '../widgets/agri_input_field.dart';
import '../widgets/result_table.dart';
import '../theme/app_theme.dart';
import '../utils/bac_distribution.dart';
import 'bac_distribution_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CalculeScreen extends StatefulWidget {
  const CalculeScreen({super.key});

  @override
  State<CalculeScreen> createState() => _CalculeScreenState();
}

class _CalculeScreenState extends State<CalculeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _ionicSectionKey = GlobalKey();
  final GlobalKey _ecSectionKey = GlobalKey();

  // Controllers
  final mkpA17 = TextEditingController();
  final npA5 = TextEditingController();
  final spA6 = TextEditingController();
  final calA7 = TextEditingController();
  final acidA8 = TextEditingController();
  final aphA9 = TextEditingController();
  final ammonA10 = TextEditingController();
  final mapA11 = TextEditingController();
  final ureeA15 = TextEditingController();
  final aCIDSULB18 = TextEditingController();
  final nmgoA16 = TextEditingController();
  final sulamoA14 = TextEditingController();
  final chlorA12 = TextEditingController();
  final smgoA13 = TextEditingController();
  final eeiM24 = TextEditingController();
  final supB31 = TextEditingController();
  final sfF3 = TextEditingController();
  final smlM21 = TextEditingController();

  CalculeModel? result;

  double parse(String text) {
    if (text.trim().isEmpty) return 0.0;
    text = text.replaceAll(',', '.');
    return double.tryParse(text) ?? 0.0;
  }

  void _calculer() {
    HapticFeedback.mediumImpact();
    setState(() {
      result = CalculeModel.calculate(
        mkp: parse(mkpA17.text),
        nk: parse(npA5.text),
        sp: parse(spA6.text),
        nca: parse(calA7.text),
        an: parse(acidA8.text),
        aph: parse(aphA9.text),
        ammon: parse(ammonA10.text),
        map: parse(mapA11.text),
        uree: parse(ureeA15.text),
        asul: parse(aCIDSULB18.text),
        nmgo: parse(nmgoA16.text),
        sulamo: parse(sulamoA14.text),
        clkIn: parse(chlorA12.text),
        smgo: parse(smgoA13.text),
        ecBassin: parse(eeiM24.text),
        surface: parse(supB31.text),
        sf: parse(sfF3.text),
        sm: parse(smlM21.text),
      );
    });
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_ionicSectionKey.currentContext != null) {
        Scrollable.ensureVisible(
          _ionicSectionKey.currentContext!,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  void _delete() {
    HapticFeedback.lightImpact();
    mkpA17.clear();
    npA5.clear();
    spA6.clear();
    calA7.clear();
    acidA8.clear();
    aphA9.clear();
    ammonA10.clear();
    mapA11.clear();
    ureeA15.clear();
    aCIDSULB18.clear();
    nmgoA16.clear();
    sulamoA14.clear();
    chlorA12.clear();
    smgoA13.clear();
    eeiM24.clear();
    supB31.clear();
    sfF3.clear();
    smlM21.clear();

    setState(() {
      result = null;
    });

    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _suivant() {
    HapticFeedback.mediumImpact();
    if (_ecSectionKey.currentContext != null) {
      Scrollable.ensureVisible(
        _ecSectionKey.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _handleDistribuerBacs() {
    HapticFeedback.heavyImpact();
    final distResult = distribuerBacs(
      npA5:       double.tryParse(npA5.text)       ?? 0,
      spA6:       double.tryParse(spA6.text)       ?? 0,
      calA7:      double.tryParse(calA7.text)      ?? 0,
      acidA8:     double.tryParse(acidA8.text)     ?? 0,
      aphA9:      double.tryParse(aphA9.text)      ?? 0,
      ammonA10:   double.tryParse(ammonA10.text)   ?? 0,
      mapA11:     double.tryParse(mapA11.text)     ?? 0,
      chlorA12:   double.tryParse(chlorA12.text)   ?? 0,
      smgoA13:    double.tryParse(smgoA13.text)    ?? 0,
      sulamoA14:  double.tryParse(sulamoA14.text)  ?? 0,
      ureeA15:    double.tryParse(ureeA15.text)    ?? 0,
      nmgoA16:    double.tryParse(nmgoA16.text)    ?? 0,
      mkpA17:     double.tryParse(mkpA17.text)     ?? 0,
      ACIDSULB18: double.tryParse(aCIDSULB18.text) ?? 0,
      sfF3:       double.tryParse(sfF3.text)       ?? 0,
    );
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, _, _) => BacDistributionScreen(result: distResult),
        transitionsBuilder: (_, animation, _, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  ReportData _buildReportData({DistributionResult? distribution}) {
    return ReportData(
      mkpA17: parse(mkpA17.text),
      npA5: parse(npA5.text),
      spA6: parse(spA6.text),
      calA7: parse(calA7.text),
      acidA8: parse(acidA8.text),
      aphA9: parse(aphA9.text),
      ammonA10: parse(ammonA10.text),
      mapA11: parse(mapA11.text),
      ureeA15: parse(ureeA15.text),
      ACIDSULB18: parse(aCIDSULB18.text),
      nmgoA16: parse(nmgoA16.text),
      sulamoA14: parse(sulamoA14.text),
      chlorA12: parse(chlorA12.text),
      smgoA13: parse(smgoA13.text),
      eeiM24: parse(eeiM24.text),
      supB31: parse(supB31.text),
      sfF3: parse(sfF3.text),
      smlM21: parse(smlM21.text),
      no3: result?.no3 ?? 0.0,
      nh4: result?.nh4 ?? 0.0,
      h2po4: result?.h2po4 ?? 0.0,
      k: result?.k ?? 0.0,
      so42: result?.so42 ?? 0.0,
      ca: result?.ca ?? 0.0,
      h: result?.h ?? 0.0,
      clk: result?.clk ?? 0.0,
      mg2: result?.mg2 ?? 0.0,
      qgl: result?.qgl ?? 0.0,
      ecf: result?.ecf ?? 0.0,
      con: result?.con ?? 0.0,
      unitN: result?.n ?? 0.0,
      unitP: result?.p ?? 0.0,
      unitK2O: result?.k2o ?? 0.0,
      unitCaO: result?.cao ?? 0.0,
      unitMgO: result?.mgo ?? 0.0,
      eqN: result?.en ?? 0.0,
      eqP: result?.ef ?? 0.0,
      eqK: result?.ek ?? 0.0,
      eqCa: result?.eca ?? 0.0,
      eqMg: result?.emgo ?? 0.0,
      nHa: result?.nha ?? 0.0,
      pHa: result?.pha ?? 0.0,
      kHa: result?.kha ?? 0.0,
      caHa: result?.caoha ?? 0.0,
      mgHa: result?.mgoha ?? 0.0,
      pNO3: result?.pno3 ?? 0.0,
      pNH4: result?.pnh4 ?? 0.0,
      distribution: distribution,
      generatedAt: DateTime.now(),
    );
  }

  void _showPdfActionSheet() {
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Veuillez calculer d\'abord.')));
      return;
    }
    
    final dist = distribuerBacs(
      npA5:       double.tryParse(npA5.text)       ?? 0,
      spA6:       double.tryParse(spA6.text)       ?? 0,
      calA7:      double.tryParse(calA7.text)      ?? 0,
      acidA8:     double.tryParse(acidA8.text)     ?? 0,
      aphA9:      double.tryParse(aphA9.text)      ?? 0,
      ammonA10:   double.tryParse(ammonA10.text)   ?? 0,
      mapA11:     double.tryParse(mapA11.text)     ?? 0,
      chlorA12:   double.tryParse(chlorA12.text)   ?? 0,
      smgoA13:    double.tryParse(smgoA13.text)    ?? 0,
      sulamoA14:  double.tryParse(sulamoA14.text)  ?? 0,
      ureeA15:    double.tryParse(ureeA15.text)    ?? 0,
      nmgoA16:    double.tryParse(nmgoA16.text)    ?? 0,
      mkpA17:     double.tryParse(mkpA17.text)     ?? 0,
      ACIDSULB18: double.tryParse(aCIDSULB18.text) ?? 0,
      sfF3:       double.tryParse(sfF3.text)       ?? 0,
    );

    showModalBottomSheet(
      context: context,
      builder: (context) => PdfActionSheet(reportData: _buildReportData(distribution: dist)),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12, left: 4),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryLight, size: 20),
          const SizedBox(width: 8),
          Text(
            title,
            style: GoogleFonts.playfairDisplay(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputGroup(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.mistWhite,
      appBar: AppBar(
        title: Text('Calculateur NPK', style: AppTheme.appBarTitle),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppTheme.primaryDark),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: AppTheme.slateGray),
            onPressed: _delete,
            tooltip: 'Réinitialiser',
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Engrais Potassiques', Icons.eco_rounded),
            _buildInputGroup([
              Row(
                children: [
                  Expanded(child: AgriInputField(label: 'MKP', controller: mkpA17)),
                  const SizedBox(width: 12),
                  Expanded(child: AgriInputField(label: 'Nitrate K', controller: npA5)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: AgriInputField(label: 'Sulfate Potass', controller: spA6)),
                  const SizedBox(width: 12),
                  Expanded(child: AgriInputField(label: 'Chlorure K', controller: chlorA12)),
                ],
              ),
            ]).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),

            _buildSectionHeader('Azote & Calcium', Icons.science_rounded),
            _buildInputGroup([
              Row(
                children: [
                  Expanded(child: AgriInputField(label: 'Nitrate Ca', controller: calA7)),
                  const SizedBox(width: 12),
                  Expanded(child: AgriInputField(label: 'Ammonitrate', controller: ammonA10)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: AgriInputField(label: 'Urée', controller: ureeA15)),
                  const SizedBox(width: 12),
                  Expanded(child: AgriInputField(label: 'Sulfate Ammo', controller: sulamoA14)),
                ],
              ),
            ]).animate().fadeIn(duration: 400.ms, delay: 100.ms).slideY(begin: 0.1),

            _buildSectionHeader('Acides & Phosphate', Icons.water_drop_rounded),
            _buildInputGroup([
              Row(
                children: [
                  Expanded(child: AgriInputField(label: 'Acide Nitrique', controller: acidA8)),
                  const SizedBox(width: 12),
                  Expanded(child: AgriInputField(label: 'Acide Phos', controller: aphA9)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: AgriInputField(label: 'MAP', controller: mapA11)),
                  const SizedBox(width: 12),
                  Expanded(child: AgriInputField(label: 'Acide Sulfu', controller: aCIDSULB18)),
                ],
              ),
            ]).animate().fadeIn(duration: 400.ms, delay: 200.ms).slideY(begin: 0.1),

            _buildSectionHeader('Magnésiens', Icons.spa_rounded),
            _buildInputGroup([
              Row(
                children: [
                  Expanded(child: AgriInputField(label: 'Nitrate MgO', controller: nmgoA16)),
                  const SizedBox(width: 12),
                  Expanded(child: AgriInputField(label: 'Sulfate MgO', controller: smgoA13)),
                ],
              ),
            ]).animate().fadeIn(duration: 400.ms, delay: 300.ms).slideY(begin: 0.1),

            _buildSectionHeader('Paramètres Système', Icons.settings_applications_rounded),
            _buildInputGroup([
              Row(
                children: [
                  Expanded(child: AgriInputField(label: 'EC Bassin', controller: eeiM24)),
                  const SizedBox(width: 12),
                  Expanded(child: AgriInputField(label: 'Superficie', controller: supB31)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: AgriInputField(label: 'Sol. Fille / T', controller: sfF3)),
                  const SizedBox(width: 12),
                  Expanded(child: AgriInputField(label: 'Sol. Mère / L', controller: smlM21)),
                ],
              ),
            ]).animate().fadeIn(duration: 400.ms, delay: 400.ms).slideY(begin: 0.1),

            const SizedBox(height: 32),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: ElevatedButton.icon(
                    onPressed: _calculer,
                    icon: const Icon(Icons.calculate_rounded),
                    label: Text('Analyser', style: GoogleFonts.dmSans(fontWeight: FontWeight.w600, fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryLight,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 4,
                      shadowColor: AppTheme.primaryLight.withOpacity(0.4),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: _handleDistribuerBacs,
                    icon: const Icon(Icons.route_rounded, size: 20),
                    label: Text('Bacs', style: GoogleFonts.dmSans(fontWeight: FontWeight.w600, fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1565C0),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 4,
                      shadowColor: const Color(0xFF1565C0).withOpacity(0.4),
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 400.ms, delay: 500.ms).scaleXY(begin: 0.95),

            if (result != null) ...[
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _showPdfActionSheet,
                    icon: const Icon(Icons.picture_as_pdf_rounded),
                    label: Text('Export PDF', style: GoogleFonts.dmSans(fontWeight: FontWeight.w600, fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 4,
                      shadowColor: Colors.redAccent.withOpacity(0.4),
                    ),
                  ),
                ).animate().fadeIn(duration: 400.ms, delay: 600.ms).scaleXY(begin: 0.95),
                const SizedBox(height: 24),
              Container(key: _ionicSectionKey),
              ResultTable(
                title: 'Équilibre Ionique',
                gradient: const LinearGradient(colors: [Color(0xFF0A2E1A), Color(0xFF1B5E20)]),
                headers: const ['Ion', 'meq/L'],
                rows: [
                  [const ChemText(text: 'NO', subscript: '3', superscript: '-'), _valText(result!.no3)],
                  [const ChemText(text: 'NH', subscript: '4', superscript: '+'), _valText(result!.nh4)],
                  [const ChemText(text: 'H', subscript: '2', superscript: null).buildSpan('PO', subscript: '4', superscript: '-'), _valText(result!.h2po4)], 
                  [const ChemText(text: 'K', superscript: '+'), _valText(result!.k)],
                  [const ChemText(text: 'SO', subscript: '4', superscript: '2-'), _valText(result!.so42)],
                  [const ChemText(text: 'Ca', superscript: '2+'), _valText(result!.ca)],
                  [const ChemText(text: 'H', superscript: '+'), _valText(result!.h)],
                  [const ChemText(text: 'Cl', superscript: '-'), _valText(result!.clk)],
                  [const ChemText(text: 'Mg', superscript: '2+'), _valText(result!.mg2)],
                ],
              ).animate().fadeIn().slideY(begin: 0.1),
              
              const SizedBox(height: 20),
              Center(
                child: TextButton.icon(
                  onPressed: _suivant,
                  icon: const Icon(Icons.arrow_downward_rounded),
                  label: const Text("Voir plus"),
                  style: TextButton.styleFrom(foregroundColor: AppTheme.primaryLight),
                ),
              ),
              const SizedBox(height: 20),
              
              Container(key: _ecSectionKey),
              ResultTable(
                title: 'Conductivité Électrique',
                gradient: const LinearGradient(colors: [Color(0xFF37474F), Color(0xFF546E7A)]),
                headers: const ['Paramètre', 'Valeur'],
                rows: [
                  [const Text('Q g/L irrigation', style: TextStyle(color: Colors.white, fontSize: 13)), _valText(result!.qgl)],
                  [const Text('EC irrigation', style: TextStyle(color: Colors.white, fontSize: 13)), _valText(result!.ecf)],
                  [const Text('Concentration SM', style: TextStyle(color: Colors.white, fontSize: 13)), _valText(result!.con)],
                ],
              ).animate().fadeIn().slideY(begin: 0.1),

              const SizedBox(height: 30),
              ResultTable(
                title: 'Unités Fertilisantes',
                gradient: const LinearGradient(colors: [Color(0xFFbf360c), Color(0xFFd84315)]),
                headers: const ['Élément', 'Unit total', 'Équilibre', 'Unit/ha'],
                rows: [
                  [_plain('N'), _valText(result!.n), _valText(result!.en), _valText(result!.nha)],
                  [const ChemText(text: 'P', subscript: '2', superscript: null).buildSpan('O', subscript: '5'), _valText(result!.p), _valText(result!.ef), _valText(result!.pha)], 
                  [const ChemText(text: 'K', subscript: '2', superscript: null).buildSpan('O', subscript: null), _valText(result!.k2o), _valText(result!.ek), _valText(result!.kha)],
                  [_plain('CaO'), _valText(result!.cao), _valText(result!.eca), _valText(result!.caoha)],
                  [_plain('MgO'), _valText(result!.mgo), _valText(result!.emgo), _valText(result!.mgoha)],
                  [const ChemText(text: '%NO', subscript: '3', superscript: '-'), _valText(result!.pno3), const SizedBox(), const SizedBox()],
                  [const ChemText(text: '%NH', subscript: '4', superscript: '+'), _valText(result!.pnh4), const SizedBox(), const SizedBox()],
                ],
              ).animate().fadeIn().slideY(begin: 0.1),
            ],
          ],
        ),
      ),
    );
  }

  Widget _valText(double val) {
    if (val.isNaN || val.isInfinite) return Text('---', style: GoogleFonts.dmMono(color: Colors.white70, fontSize: 14));
    return Text(val.toStringAsFixed(2), style: GoogleFonts.dmMono(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold));
  }

  Widget _plain(String t) {
    return Text(t, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold));
  }
}

extension on ChemText {
  Widget buildSpan(String text2, {String? subscript, String? superscript}) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        children: [
          TextSpan(text: text),
          if (this.subscript != null)
            WidgetSpan(
              child: Transform.translate(
                offset: const Offset(0, 4),
                child: Text(
                  this.subscript!,
                  style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          if (this.superscript != null)
            WidgetSpan(
              child: Transform.translate(
                offset: const Offset(0, -6),
                child: Text(
                  this.superscript!,
                  style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            TextSpan(text: text2),
            if (subscript != null)
            WidgetSpan(
              child: Transform.translate(
                offset: const Offset(0, 4),
                child: Text(
                  subscript,
                  style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          if (superscript != null)
            WidgetSpan(
              child: Transform.translate(
                offset: const Offset(0, -6),
                child: Text(
                  superscript,
                  style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }
}