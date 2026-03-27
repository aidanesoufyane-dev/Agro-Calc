import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/bac_item.dart';
import '../theme/app_theme.dart';

class BacDistributionScreen extends StatelessWidget {
  final DistributionResult result;

  const BacDistributionScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.mistWhite,
      appBar: AppBar(
        title: Text('Distribution des Bacs', style: AppTheme.appBarTitle),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppTheme.primaryDark),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildStatusBanner().animate().fadeIn(duration: 400.ms).slideY(begin: -0.1),
            if (result.moved.nitrateK.kg > 0 || result.moved.ammonitrate.kg > 0 || result.moved.uree.kg > 0 || result.moved.nMgo.kg > 0)
              _buildMovementSummary().animate().fadeIn(duration: 400.ms, delay: 100.ms).slideY(begin: -0.1), 
            const SizedBox(height: 24),
            _buildBacCard(title: "Bac A", subtitle: "Nitrate Ca (+ ajustements)", bacResult: result.bacA, gradient: const LinearGradient(colors: [Color(0xFF0A2E1A), Color(0xFF1B5E20)]), iconColor: const Color(0xFF8BC34A), infoBgColor: const Color(0xFFF4F9E8), chipBorderColor: const Color(0xFFB8D98A)).animate().fadeIn(duration: 500.ms, delay: 200.ms).slideX(begin: -0.1),
            const SizedBox(height: 20),
            _buildBacCard(title: "Bac B", subtitle: "Engrais + Acide Phosphorique & Sulfurique", bacResult: result.bacB, gradient: const LinearGradient(colors: [Color(0xFF0D47A1), Color(0xFF1976D2)]), iconColor: const Color(0xFF64B5F6), infoBgColor: const Color(0xFFEAF4FE), chipBorderColor: const Color(0xFF90CAF9)).animate().fadeIn(duration: 500.ms, delay: 300.ms).slideX(begin: 0.1),
            const SizedBox(height: 20),
            _buildBacCard(title: "Bac C", subtitle: "Acide Nitrique uniquement", bacResult: result.bacC, gradient: const LinearGradient(colors: [Color(0xFFE65100), Color(0xFFF57C00)]), iconColor: const Color(0xFFFFB74D), infoBgColor: const Color(0xFFFFF0EB), chipBorderColor: const Color(0xFFFFAB91)).animate().fadeIn(duration: 500.ms, delay: 400.ms).slideX(begin: -0.1),
            const SizedBox(height: 32),
            _buildComparisonCard().animate().fadeIn(duration: 500.ms, delay: 500.ms).scaleXY(begin: 0.95),   
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBanner() {
    if (result.warningMessage != null) {
      return _Banner(icon: Icons.warning_amber_rounded, color: const Color(0xFFF57C00), bgColor: const Color(0xFFFFF3E0), borderColor: const Color(0xFFFFCC80), text: result.warningMessage!);
    } else if (result.isBalanced) {
      return _Banner(icon: Icons.check_circle_outline_rounded, color: const Color(0xFF388E3C), bgColor: const Color(0xFFE8F5E9), borderColor: const Color(0xFFA5D6A7), text: "Bacs parfaitement equilibres : BacA = BacB",);
    }
    return const SizedBox();
  }

  Widget _buildMovementSummary() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF90CAF9)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFF5F5F5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.sync_alt_rounded, color: Color(0xFF1976D2), size: 20),
              const SizedBox(width: 8),
              Text(
                "Ajustements effectues (Bac B → Bac A)",
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (result.moved.nitrateK.kg > 0)
            _buildMovementRow("Nitrate K déplacé :", result.moved.nitrateK.kg),
          if (result.moved.ammonitrate.kg > 0) ...[
            const SizedBox(height: 8),
            _buildMovementRow("Ammonitrate déplacé :", result.moved.ammonitrate.kg),
          ],
          if (result.moved.uree.kg > 0) ...[
            const SizedBox(height: 8),
            _buildMovementRow("UREE deplacee :", result.moved.uree.kg),
          ],
          if (result.moved.nMgo.kg > 0) ...[
            const SizedBox(height: 8),
            _buildMovementRow("N MgO deplace :", result.moved.nMgo.kg),
          ],
        ],
      ),
    );
  }

  Widget _buildMovementRow(String label, double kg) {
    return Row(
      children: [
        const Icon(Icons.arrow_upward_rounded, color: Color(0xFF1976D2), size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(label, style: GoogleFonts.dmSans(color: AppTheme.slateGray, fontSize: 13)),
        ),
        Text(
          "${kg.toStringAsFixed(2)} kg",
          style: GoogleFonts.dmMono(fontWeight: FontWeight.w600, color: AppTheme.primaryDark, fontSize: 13), 
        ),
      ],
    );
  }

  Widget _buildBacCard({
    required Color infoBgColor,
    required Color chipBorderColor,
    required String title,
    required String subtitle,
    required BacResult bacResult,
    required Gradient gradient,
    required Color iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFF0F0F0),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(gradient: gradient),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0x33FFFFFF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.water_drop_rounded, color: iconColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.playfairDisplay(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: GoogleFonts.dmSans(
                          color: Color(0xCCFFFFFF),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            color: AppTheme.mistWhite,
            child: Row(
              children: [
                Expanded(flex: 5, child: Text("Engrais", style: GoogleFonts.dmSans(color: AppTheme.slateGray, fontWeight: FontWeight.bold, fontSize: 12))),
                Expanded(flex: 3, child: Text("Quantité (kg)", textAlign: TextAlign.right, style: GoogleFonts.dmSans(color: AppTheme.slateGray, fontWeight: FontWeight.bold, fontSize: 12))),
              ],
            ),
          ),
          ...bacResult.items.asMap().entries.map((entry) {
            int idx = entry.key;
            BacItem item = entry.value;
            bool moved = item.wasMoved;

            return Container(
              decoration: BoxDecoration(
                color: moved ? const Color(0xFFFFF8E1) : (idx % 2 == 0 ? Colors.white : AppTheme.mistWhite),
                border: Border(
                  left: BorderSide(
                    color: moved ? const Color(0xFFFFB300) : Colors.transparent,
                    width: 4,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(
                      item.label,
                      style: GoogleFonts.dmSans(
                        color: moved ? const Color(0xFFF57C00) : AppTheme.primaryDark,
                        fontWeight: moved ? FontWeight.bold : FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      item.kg.toStringAsFixed(2),
                      textAlign: TextAlign.right,
                      style: GoogleFonts.dmMono(color: AppTheme.primaryDark, fontSize: 13),
                    ),
                  ),
                ],
              ),
            );
          }),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.mistWhite,
              border: Border(top: BorderSide(color: AppTheme.inputBorder)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text("TOTAL", style: GoogleFonts.dmSans(color: AppTheme.primaryDark, fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "${bacResult.totalKg.toStringAsFixed(2)} kg",
                    textAlign: TextAlign.right,
                    style: GoogleFonts.dmMono(color: AppTheme.primaryDark, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: infoBgColor,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: chipBorderColor),
                    ),
                    child: Column(
                      children: [
                        Text("Volume", style: GoogleFonts.dmSans(fontSize: 11, color: AppTheme.slateGray)),
                        Text("${bacResult.volumeL.toStringAsFixed(0)} L", style: GoogleFonts.dmMono(fontSize: 14, fontWeight: FontWeight.bold, color: iconColor)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: chipBorderColor),
                    ),
                    child: Column(
                      children: [
                        Text("Concentration", style: GoogleFonts.dmSans(fontSize: 11, color: AppTheme.slateGray)),
                        Text("${bacResult.concentrationGperL.toStringAsFixed(2)} g/L", style: GoogleFonts.dmMono(fontSize: 14, fontWeight: FontWeight.bold, color: iconColor)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.inputBorder),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFF5F5F5),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.balance_rounded, color: AppTheme.primaryMid, size: 22),
              const SizedBox(width: 8),
              Text(
                "Comparaison Bac A / Bac B",
                style: GoogleFonts.playfairDisplay(
                  color: AppTheme.primaryDark,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildComparisonRow("", "Total (kg)", "Conc. (g/L)", AppTheme.slateGray, isBold: true),
            const Divider(height: 24),
            _buildComparisonRow("Bac A", result.bacA.totalKg, result.bacA.concentrationGperL, AppTheme.slateGray),      
          const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(height: 1)),
          _buildComparisonRow("Bac B", result.bacB.totalKg, result.bacB.concentrationGperL, AppTheme.slateGray),      
          const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(height: 1)),
          
          Container(
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.mistWhite,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildBalanceRow(
                  "Écart BacA vs BacB", 
                  " kg", 
                  result.balance.achieved ? const Color(0xFF388E3C) : const Color(0xFFF57C00)
                ),
                
                const SizedBox(height: 6),
                _buildBalanceRow(
                  "Statut", 
                  result.balance.achieved ? 'BacA = BacB' : 'Desequilibre', 
                  result.balance.achieved ? const Color(0xFF388E3C) : const Color(0xFFD32F2F),
                  isBold: true
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

Widget _buildComparisonRow(String label, dynamic val1, dynamic val2, Color color, {bool isBold = false}) {
    String str1 = val1 is double ? val1.toStringAsFixed(2) : val1.toString();
    String str2 = val2 is double ? val2.toStringAsFixed(2) : val2.toString();

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(label, style: GoogleFonts.dmSans(color: color, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ),
        Expanded(
          flex: 1,
          child: Text(
            str1,
            style: GoogleFonts.dmMono(color: color, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
            textAlign: TextAlign.right,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            str2,
            style: GoogleFonts.dmMono(color: color, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceRow(String label, String value, Color color, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.dmSans(color: AppTheme.slateGray, fontSize: 13)),
        Text(value, style: GoogleFonts.dmSans(color: color, fontWeight: isBold ? FontWeight.bold : FontWeight.w600, fontSize: 13)),
      ],
    );
  }
}

class _Banner extends StatelessWidget {
  final Color borderColor;
  final IconData icon;
  final Color color;
  final Color bgColor;
  final String text;

  const _Banner({required this.borderColor,
    required this.icon, required this.color, required this.bgColor, required this.text});       

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.dmSans(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

