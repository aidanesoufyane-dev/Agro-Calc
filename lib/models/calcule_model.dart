class CalculeModel {
  final double no3;
  final double nh4;
  final double h2po4;
  final double k;
  final double so42;
  final double ca;
  final double h;
  final double clk;
  final double mg2;

  final double qgl;
  final double ecf;
  final double con;

  final double n;
  final double en;
  final double nha;
  
  final double p;
  final double ef;
  final double pha;
  
  final double k2o;
  final double ek;
  final double kha;
  
  final double cao;
  final double eca;
  final double caoha;
  
  final double mgo;
  final double emgo;
  final double mgoha;
  
  final double pno3;
  final double pnh4;

  CalculeModel({
    required this.no3, required this.nh4, required this.h2po4, required this.k, required this.so42,
    required this.ca, required this.h, required this.clk, required this.mg2,
    required this.qgl, required this.ecf, required this.con,
    required this.n, required this.en, required this.nha,
    required this.p, required this.ef, required this.pha,
    required this.k2o, required this.ek, required this.kha,
    required this.cao, required this.eca, required this.caoha,
    required this.mgo, required this.emgo, required this.mgoha,
    required this.pno3, required this.pnh4,
  });

  static CalculeModel calculate({
    required double mkp, required double nk, required double sp, required double nca,
    required double an, required double aph, required double ammon, required double map,
    required double uree, required double asul, required double nmgo, required double sulamo,
    required double clkIn, required double smgo, required double ecBassin, required double surface,
    required double sf, required double sm,
  }) {
    // Variables exactes au fichier Java (B = inputs, C = constantes)
    final double B5 = nk;    final double B6 = sp;     final double B7 = nca;
    final double B8 = an;    final double B9 = aph;    final double B10 = ammon;
    final double B11 = map;  final double B12 = clkIn; final double B13 = smgo;
    final double B14 = sulamo; final double B15 = uree; final double B16 = nmgo;
    final double B17 = mkp;  final double B18 = asul;  final double F3 = sf;
    final double M20 = ecBassin; final double M23 = sm; final double B32 = surface;

    const double C5 = 101;   const double C6 = 87;     const double C7 = 82;
    const double C8 = 63;    const double C9 = 98;     const double C10 = 80;
    const double C11 = 115;  const double C12 = 75;    const double C13 = 123.2;
    const double C14 = 66;   const double C15 = 58;    const double C16 = 128;
    const double C17 = 136;  const double C18 = 47;

    // LES ENGRAIS UTILISER
    double NP = B5 / F3 / C5 * 1000;
    double SP = B6 / F3 / C6 * 1000;
    double CAL = B7 / F3 / C7 * 1000;
    double ACID = B8 / F3 / C8 * 1000;
    double APH = B9 / F3 / C9 * 1000;
    double AMMON = B10 / F3 / C10 * 1000;
    double MAP = B11 / F3 / C11 * 1000;
    double CL = B12 / F3 / C12 * 1000;
    double SMGO = B13 / F3 / C13 * 1000;
    double SAMO = B14 / F3 / C14 * 1000;
    double UREE = B15 / F3 / C15 * 1000;
    double NMGO = B16 / F3 / C16 * 1000;
    double MKP = B17 / F3 / C17 * 1000;
    double ASUL = B18 / F3 / C18 * 1000;

    // iones
    double NO3 = NP + CAL + ACID + AMMON + NMGO;
    double NH4 = AMMON + MAP + SAMO + UREE;
    double H2P04 = APH + MAP + MKP;
    double K = NP + SP + CL + MKP;
    double CLK = CL;
    double MG2 = SMGO + NMGO;
    double CA = CAL;
    double H = ACID + APH + ASUL;
    double SO42 = SP + SMGO + SAMO + ASUL;

    // outill pour calcule EC
    double S = B5 + B6 + B7 + B8 + B9 + B10 + B11 + B12 + B13 + B14 + B16 + B17 + B18;
    double QGL = S / F3;
    double ECF = M20 + (QGL / 0.85);
    double CON = S / M23 * 1000;

    // UNITI
    double N = (B10 * 0.335) + (B11 * 0.12) + (B5 * 0.13) + (B7 * 0.155) + (B8 * 0.14) + (B14 * 0.21) + (B15 * 0.46) + (B16 * 0.11);
    double P = (B11 * 0.61) + (B9 * 0.54) + (B17 * 0.52);
    double K2O = (B5 * 0.46) + (B6 * 0.5) + (B12 * 0.60) + (B17 * 0.34);
    double CAO = B7 * 0.265;
    double MGO = (B13 * 0.16) + (B16 * 0.16);

    // EQUILIBRE
    double EN = 1;
    double EF = P / N;
    double EK = K2O / N;
    double ECA = CAO / N;
    double EMGO = MGO / N;

    // UINITI /HA
    double NHA = N / B32;
    double PHA = P / B32;
    double KHA = K2O / B32;
    double CAOHA = CAO / B32;
    double MGOHA = MGO / B32;

    // p
    double PNO3 = ((B10 * 0.1675) + (B5 * 0.13) + (B7 * 0.155) + (B8 * 0.14) + (B16 * 0.11)) / N * 100;
    double PNH4 = ((B11 * 0.12) + (B10 * 0.1675) + (B14 * 0.21) + (B15 * 0.46)) / N * 100;

    // Helper pour éviter les crashs sur la conversion en String (NaN / Infinity) 
    // qui se produiraient lors des divisions par zéro (ex: F3=0)
    double fmt(double val) {
      if (val.isNaN || val.isInfinite) return 0.0;
      return double.parse(val.toStringAsFixed(2));
    }

    return CalculeModel(
      no3: fmt(NO3),
      nh4: fmt(NH4),
      h2po4: fmt(H2P04),
      k: fmt(K),
      so42: fmt(SO42),
      ca: fmt(CA),
      h: fmt(H),
      clk: fmt(CLK),
      mg2: fmt(MG2),
      qgl: fmt(QGL),
      ecf: fmt(ECF),
      con: fmt(CON),
      n: fmt(N),
      en: fmt(EN),
      nha: fmt(NHA),
      p: fmt(P),
      ef: fmt(EF),
      pha: fmt(PHA),
      k2o: fmt(K2O),
      ek: fmt(EK),
      kha: fmt(KHA),
      cao: fmt(CAO),
      eca: fmt(ECA),
      caoha: fmt(CAOHA),
      mgo: fmt(MGO),
      emgo: fmt(EMGO),
      mgoha: fmt(MGOHA),
      pno3: fmt(PNO3),
      pnh4: fmt(PNH4),
    );
}

}
