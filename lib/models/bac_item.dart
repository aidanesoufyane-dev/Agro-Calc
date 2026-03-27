class BacItem {
  final String label;
  double kg;
  final bool wasMoved;
  BacItem({
    required this.label,
    required this.kg,
    this.wasMoved = false,
  });
}

class BacResult {
  final List<BacItem> items;
  final double totalKg;
  final double volumeL;
  final double concentrationGperL;
  BacResult({
    required this.items,
    required this.totalKg,
    required this.volumeL,
    required this.concentrationGperL,
  });
}

class BalanceSummary {
  final double diffKg;   // |BacA - BacB| in kg
  final double diffPct;  // diffKg / BacB * 100
  final bool achieved;   // diffKg < 0.01 (pratically equal)
  BalanceSummary({
    required this.diffKg,
    required this.diffPct,
    required this.achieved,
  });
}

class MovedItem {
  final double kg;
  MovedItem({required this.kg});
}

class MovedSummary {
  final MovedItem nitrateK;
  final MovedItem ammonitrate;
  final MovedItem uree;
  final MovedItem nMgo;
  MovedSummary({
    required this.nitrateK,
    required this.ammonitrate,
    required this.uree,
    required this.nMgo,
  });
}

class DistributionResult {
  final BacResult bacA;
  final BacResult bacB;
  final BacResult bacC;
  final MovedSummary moved;
  final bool isBalanced;
  final BalanceSummary balance;
  final String? warningMessage;

  DistributionResult({
    required this.bacA,
    required this.bacB,
    required this.bacC,
    required this.moved,
    required this.isBalanced,
    required this.balance,
    this.warningMessage,
  });
}
