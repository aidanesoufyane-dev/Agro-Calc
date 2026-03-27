import 'dart:math' as math;
import '../models/bac_item.dart';

const double _BAC_VOLUME = 1000.0;

DistributionResult distribuerBacs({
  required double npA5,
  required double spA6,
  required double calA7,
  required double acidA8,
  required double aphA9,
  required double ammonA10,
  required double mapA11,
  required double chlorA12,
  required double smgoA13,
  required double sulamoA14,
  required double ureeA15,
  required double nmgoA16,
  required double mkpA17,
  required double ACIDSULB18,
  required double sfF3,
}) {

  // STEP 1 — BacA mutable map (label -> kg)
  final Map<String, double> bacAkg = {
    'Nitrate Ca': calA7,
  };

  // STEP 2 — BacB mutable values
  double bbNpa5       = npA5;
  double bbAmmona10   = ammonA10;
  double bbUreea15    = ureeA15;
  double bbNmgoa16    = nmgoA16;
  // Fixed BacB items (never move)
  final double bbSpa6       = spA6;
  final double bbMapa11     = mapA11;
  final double bbChlora12   = chlorA12;
  final double bbSmgoa13    = smgoA13;
  final double bbSulamoa14  = sulamoA14;
  final double bbMkpa17     = mkpA17;
  final double bbApha9      = aphA9;
  final double bbAcidsulb18 = ACIDSULB18;

  // STEP 3 — BacC fixed
  final double bcAcida8 = acidA8;

  // STEP 4 — Total functions
  // IMPORTANT: recalculated at every iteration
  double totalA() =>
    bacAkg.values.fold(0.0, (s, v) => s + v);

  double totalB() =>
    bbNpa5 + bbAmmona10 + bbUreea15 +
    bbNmgoa16 + bbSpa6 + bbMapa11 +
    bbChlora12 + bbSmgoa13 + bbSulamoa14 +
    bbMkpa17 + bbApha9 + bbAcidsulb18;

  // STEP 5 — Moved tracking
  double movedNK    = 0;
  double movedAmmon = 0;
  double movedUree  = 0;
  double movedNMgo  = 0;
  String? warningMessage;

  // STEP 6 — Balancing logic
  final double initA = totalA();
  final double initB = totalB();

  if (initB == 0) {
    warningMessage = 'BacB est vide. Aucun equilibrage possible.';

  } else if (initA > initB) {
    // BacA already heavier — cannot fix
    warningMessage =
      'BacA (${initA.toStringAsFixed(2)} kg) est '
      'superieur a BacB (${initB.toStringAsFixed(2)} kg). '
      'Aucun ajustement possible.';

  } else {
    // ── Step 1: Nitrate K ──
    {
      final double A    = totalA();
      final double B    = totalB();
      final double diff = (B - A) / 2.0; // how much BacA needs
      if (diff > 0.001 && bbNpa5 > 0.001) {
        final double moveKg = math.min(diff, bbNpa5);
        bbNpa5 -= moveKg;
        movedNK  = moveKg;
        bacAkg['Nitrate K'] =
          (bacAkg['Nitrate K'] ?? 0) + moveKg;
      }
    }

    // ── Step 2: Ammonitrate ──
    {
      final double A    = totalA();
      final double B    = totalB();
      final double diff = (B - A) / 2.0;
      if (diff > 0.001 && bbAmmona10 > 0.001) {
        final double moveKg = math.min(diff, bbAmmona10);
        bbAmmona10   -= moveKg;
        movedAmmon     = moveKg;
        bacAkg['Ammonitrate'] =
          (bacAkg['Ammonitrate'] ?? 0) + moveKg;
      }
    }

    // ── Step 3: UREE ──
    {
      final double A    = totalA();
      final double B    = totalB();
      final double diff = (B - A) / 2.0;
      if (diff > 0.001 && bbUreea15 > 0.001) {
        final double moveKg = math.min(diff, bbUreea15);
        bbUreea15 -= moveKg;
        movedUree   = moveKg;
        bacAkg['UREE'] =
          (bacAkg['UREE'] ?? 0) + moveKg;
      }
    }

    // ── Step 4: N MgO ──
    {
      final double A    = totalA();
      final double B    = totalB();
      final double diff = (B - A) / 2.0;
      if (diff > 0.001 && bbNmgoa16 > 0.001) {
        final double moveKg = math.min(diff, bbNmgoa16);
        bbNmgoa16 -= moveKg;
        movedNMgo   = moveKg;
        bacAkg['N MgO'] =
          (bacAkg['N MgO'] ?? 0) + moveKg;
      }
    }

    // ── Final check ──
    final double finalA    = totalA();
    final double finalB    = totalB();
    final double finalDiff = (finalA - finalB).abs();

    if (finalB > 0 && finalDiff > finalB * 0.05) {
      final double pct = finalDiff / finalB * 100;
      // Plus de 5% d'ecart = AVERTISSEMENT
      warningMessage =
        'Balance incomplexe : '
        'Ecart final de ${finalDiff.toStringAsFixed(2)} kg '
        '(${pct.toStringAsFixed(1)}%) superieur a la tolerance de 5%.';
    }
  }

  // STEP 7 — Build BacA items
  final List<BacItem> bacAItems = bacAkg.entries
    .where((e) => e.value > 0.0001)
    .map((e) => BacItem(
      label: e.key,
      kg: double.parse(e.value.toStringAsFixed(2)),
      wasMoved: e.key != 'Nitrate Ca',
    ))
    .toList();

  // STEP 8 — Build BacB items (filter zeros)
  final List<BacItem> bacBItems = [];
  void addB(String label, double kg) {
    if (kg > 0.0001) {
      bacBItems.add(BacItem(
      label: label,
      kg: double.parse(kg.toStringAsFixed(2)),
      wasMoved: false,
    ));
    }
  }
  addB('Nitrate K',          bbNpa5);
  addB('Ammonitrate',        bbAmmona10);
  addB('UREE',               bbUreea15);
  addB('N MgO',              bbNmgoa16);
  addB('Sulfate Potass',     bbSpa6);
  addB('MAP',                bbMapa11);
  addB('CL,K',               bbChlora12);
  addB('S MgO',              bbSmgoa13);
  addB('SULFAT AMO21',       bbSulamoa14);
  addB('MKP',                bbMkpa17);
  addB('Acide Phosphorique', bbApha9);
  addB('Acide Sulfurique',   bbAcidsulb18);

  // STEP 9 — Build BacC items
  final List<BacItem> bacCItems = [];
  if (bcAcida8 > 0.0001) {
    bacCItems.add(BacItem(
      label: 'Acide Nitrique',
      kg: double.parse(bcAcida8.toStringAsFixed(2)),
      wasMoved: false,
    ));
  }

  // STEP 10 — Compute final totals
  final double fA = bacAItems.fold(0.0,(s,i)=>s+i.kg);
  final double fB = bacBItems.fold(0.0,(s,i)=>s+i.kg);
  final double fC = bacCItems.fold(0.0,(s,i)=>s+i.kg);

  // STEP 11 — Balance summary
  final double diffKg  =
    double.parse((fA - fB).abs().toStringAsFixed(2));
  final double diffPct = fB > 0
    ? double.parse((diffKg / fB * 100).toStringAsFixed(1))
    : 0.0;

  // STEP 12 — Return result
  return DistributionResult(
    bacA: BacResult(
      items: bacAItems,
      totalKg: double.parse(fA.toStringAsFixed(2)),
      volumeL: _BAC_VOLUME,
      concentrationGperL:
        double.parse(fA.toStringAsFixed(2)),
    ),
    bacB: BacResult(
      items: bacBItems,
      totalKg: double.parse(fB.toStringAsFixed(2)),
      volumeL: _BAC_VOLUME,
      concentrationGperL:
        double.parse(fB.toStringAsFixed(2)),
    ),
    bacC: BacResult(
      items: bacCItems,
      totalKg: double.parse(fC.toStringAsFixed(2)),
      volumeL: _BAC_VOLUME,
      concentrationGperL:
        double.parse(fC.toStringAsFixed(2)),
    ),
    moved: MovedSummary(
      nitrateK:    MovedItem(kg: double.parse(movedNK.toStringAsFixed(2))),
      ammonitrate: MovedItem(kg: double.parse(movedAmmon.toStringAsFixed(2))),
      uree:        MovedItem(kg: double.parse(movedUree.toStringAsFixed(2))),
      nMgo:        MovedItem(kg: double.parse(movedNMgo.toStringAsFixed(2))),
    ),
    isBalanced:     warningMessage == null,
    warningMessage: warningMessage,
    balance: BalanceSummary(
      diffKg:       diffKg,
      diffPct:      diffPct,
      achieved:     diffPct <= 5.0,
    ),
  );
}
