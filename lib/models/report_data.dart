import '../models/bac_item.dart';

class ReportData {
  // ── Inputs ────────────────────────────────────────
  final double mkpA17, npA5, spA6, calA7, acidA8, aphA9;
  final double ammonA10, mapA11, ureeA15, ACIDSULB18;
  final double nmgoA16, sulamoA14, chlorA12, smgoA13;
  final double eeiM24, supB31, sfF3, smlM21;

  // ── Ionic balance (meq/L) ─────────────────────────
  final double no3, nh4, h2po4, k, so42, ca, h, clk, mg2;

  // ── EC ────────────────────────────────────────────
  final double qgl, ecf, con;

  // ── Fertilizer units ──────────────────────────────
  final double unitN, unitP, unitK2O, unitCaO, unitMgO;

  // ── Balance ───────────────────────────────────────
  final double eqN, eqP, eqK, eqCa, eqMg;

  // ── Units / ha ────────────────────────────────────
  final double nHa, pHa, kHa, caHa, mgHa;

  // ── Nitrogen form % ───────────────────────────────
  final double pNO3, pNH4;

  // ── Bac distribution (nullable — computed separately) ──
  final DistributionResult? distribution;

  // ── Metadata ──────────────────────────────────────
  final DateTime generatedAt;

  const ReportData({
    required this.mkpA17, required this.npA5, required this.spA6,
    required this.calA7, required this.acidA8, required this.aphA9,
    required this.ammonA10, required this.mapA11, required this.ureeA15,
    required this.ACIDSULB18, required this.nmgoA16,
    required this.sulamoA14, required this.chlorA12,
    required this.smgoA13, required this.eeiM24,
    required this.supB31, required this.sfF3, required this.smlM21,
    required this.no3, required this.nh4, required this.h2po4,
    required this.k, required this.so42, required this.ca,
    required this.h, required this.clk, required this.mg2,
    required this.qgl, required this.ecf, required this.con,
    required this.unitN, required this.unitP, required this.unitK2O,
    required this.unitCaO, required this.unitMgO,
    required this.eqN, required this.eqP, required this.eqK,
    required this.eqCa, required this.eqMg,
    required this.nHa, required this.pHa, required this.kHa,
    required this.caHa, required this.mgHa,
    required this.pNO3, required this.pNH4,
    this.distribution,
    required this.generatedAt,
  });
}
