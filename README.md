# 🌱 AgroCalc Pro

<div align="center">

![AgroCalc Pro](https://img.shields.io/badge/AgroCalc-Pro-2E7D32?style=for-the-badge&logo=leaf&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

**Professional fertigation & nutrition calculator for agronomists and farmers**

*Calculate · Distribute · Export*

</div>

---

## 📖 About

**AgroCalc Pro** is a professional mobile application built with Flutter for managing fertigation nutritional solutions in drip irrigation systems. It provides agronomists and farmers with precise calculations for NPK fertilizer formulas, ionic balance, electrical conductivity, and intelligent tank distribution — all exportable as a professional PDF report.

> Designed for real field use. Built with agrochemical accuracy in mind.

---

## ✨ Features

### 🧪 NPK Fertilizer Calculator
- Accepts **14 fertilizer inputs** in kg
- Calculates complete **ionic balance** (meq/L) for all ions:
  `NO₃⁻` `NH₄⁺` `H₂PO₄⁻` `K⁺` `SO₄²⁻` `Ca²⁺` `H⁺` `Cl⁻` `Mg²⁺`
- Computes **Electrical Conductivity (EC)** of the irrigation solution
- Calculates **fertilizer units** per application and per hectare
- Displays **NPK ratio** and nitrogen form percentage (NO₃ vs NH₄)

### 🪣 Intelligent Tank Distribution (Bac A / B / C)
- Automatically separates fertilizers into **3 compatible tanks of 1000 L each**
- **Bac A** — Calcium nitrate solution (compatible sources only)
- **Bac B** — Main fertilizer solution (sulfates, phosphates, acids)
- **Bac C** — Nitric acid only (pH adjustment)
- Smart balancing algorithm ensures **Bac A = Bac B** in concentration (g/L) so both tanks empty simultaneously
- Moves compatible fertilizers in agrochemical priority order:
  `Nitrate K → Ammonitrate → Urea → N MgO`
- Warns if perfect balance is impossible with available inputs

### 📄 Professional PDF Report
- Generates a complete **multi-page A4 PDF** with:
  - Full fertilizer input summary
  - Ionic balance table with anion/cation totals
  - EC diagnostic with visual range indicator
  - Fertilizer units and NPK ratio
  - Nitrogen form analysis with agronomic recommendations
  - Complete tank distribution with balance comparison
  - Agronomic advice section
- **Share** via WhatsApp, Email, Google Drive, Telegram
- **Print** directly from the app
- **Preview** with full zoom and page navigation

### 🎨 Agricultural UI/UX
- Animated **splash screen** with green field circle
- **Home dashboard** with quick-access cards
- Multi-section **scrollable calculator** screen
- Smooth **page transitions** and micro-animations
- Clean green agricultural color palette

---

## 📱 Screenshots

> *Add your screenshots here*

| Splash Screen | Home | Calculator | Results |
|:---:|:---:|:---:|:---:|
| `splash.png` | `home.png` | `calc.png` | `results.png` |

| Bac Distribution | PDF Report | PDF Preview |
|:---:|:---:|:---:|
| `bacs.png` | `pdf.png` | `preview.png` |

---

## 🏗️ Architecture

```
lib/
├── main.dart                          # App entry point
├── theme/
│   └── app_theme.dart                 # Colors, typography, theme
├── screens/
│   ├── splash_screen.dart             # Animated splash
│   ├── home_screen.dart               # Dashboard
│   ├── calcule_screen.dart            # Main NPK calculator
│   ├── bac_distribution_screen.dart   # Tank distribution UI
│   └── pdf_preview_screen.dart        # PDF viewer
├── models/
│   ├── report_data.dart               # PDF report data model
│   └── bac_item.dart                  # Tank distribution models
├── utils/
│   └── bac_distribution.dart          # Balancing algorithm
├── services/
│   └── pdf_report_service.dart        # PDF generation engine
└── widgets/
    ├── agri_input_field.dart           # Custom input field
    └── pdf_action_sheet.dart           # Share/print bottom sheet
```

---

## 🧮 Calculation Logic

### Fertilizer Constants (Molecular Weights)

| Fertilizer | Variable | MW (g/mol) |
|---|---|---|
| Nitrate de Potassium | npA5 | 101 |
| Sulfate de Potassium | spA6 | 87 |
| Nitrate de Calcium | calA7 | 82 |
| Acide Nitrique | acidA8 | 63 |
| Acide Phosphorique | aphA9 | 98 |
| Ammonitrate | ammonA10 | 80 |
| MAP | mapA11 | 115 |
| CL,K | chlorA12 | 75 |
| S MgO | smgoA13 | 123.2 |
| SULFAT AMO21 | sulamoA14 | 66 |
| UREE | ureeA15 | 58 |
| N MgO | nmgoA16 | 128 |
| MKP | mkpA17 | 136 |
| Acide Sulfurique | ACIDSULB18 | 47 |

### Ion Concentration Formula
```
mmol/L = (kg / Solution_fille_T / MW) × 1000
```

### Tank Balancing Algorithm
```
Goal : Bac A (kg) = Bac B (kg)
       → equal concentration in 1000L
       → both tanks empty simultaneously

Order of transfer (BacB → BacA):
  1. Nitrate K       (compatible with Ca²⁺)
  2. Ammonitrate     (compatible with Ca²⁺)
  3. Urea            (compatible with Ca²⁺)
  4. N MgO           (compatible with Ca²⁺)

At each step:
  diff   = totalB() - totalA()   ← recalculated live
  moveKg = min(diff / 2, available)
  Stop when diff < 0.001 kg
```

> The `diff / 2` formula accounts for the simultaneous effect:
> moving X kg increases BacA by X **and** decreases BacB by X,
> so the gap closes by 2X per move.

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- Android Studio or VS Code
- Android device or emulator (API 21+)

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/agrocalc-pro.git

# Navigate to project
cd agrocalc-pro

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Build APK

```bash
# Debug build
flutter build apk --debug

# Release build
flutter build apk --release
```

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^6.1.0        # Typography
  flutter_animate: ^4.5.0     # Animations
  pdf: ^3.10.8                # PDF generation
  printing: ^5.12.0           # PDF preview & print
  path_provider: ^2.1.2       # File system access
  share_plus: ^9.0.0          # Native share sheet
  intl: ^0.19.0               # Internationalization
```

---

## 🌿 Agrochemical Rules

### Tank Compatibility Matrix

| Fertilizer | Bac A | Bac B | Bac C |
|---|:---:|:---:|:---:|
| Nitrate Ca | ✅ | — | — |
| Nitrate K | ⬆️* | ✅ | — |
| Ammonitrate | ⬆️* | ✅ | — |
| Urea | ⬆️* | ✅ | — |
| N MgO | ⬆️* | ✅ | — |
| Sulfate Potass | — | ✅ | — |
| MAP | — | ✅ | — |
| S MgO | — | ✅ | — |
| Acide Phosphorique | — | ✅ | — |
| Acide Sulfurique | — | ✅ | — |
| Acide Nitrique | — | — | ✅ |

> ⬆️* = Can be moved to Bac A for balancing (compatible with Ca²⁺)

**Why separate tanks?**
Calcium (Ca²⁺) precipitates with sulfates and phosphates when concentrated together. Keeping them in separate tanks prevents clogging of drip lines.

---

## 📊 PDF Report Sections

| # | Section | Content |
|---|---|---|
| 1 | Cover | App branding, date, KPI summary |
| 2 | Inputs | All fertilizer quantities and parameters |
| 3 | Ionic Balance | meq/L per ion, anion/cation totals |
| 4 | EC Analysis | Conductivity, concentration, EC diagnostic |
| 5 | Fertilizer Units | NPK totals, balance ratio, units/ha |
| 6 | Nitrogen Form | % NO₃ vs NH₄ with recommendations |
| 7 | Tank Distribution | Bac A/B/C breakdown with balance check |
| 8 | Agronomic Advice | Auto-generated recommendations |

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

Built with ❤️ for the agricultural community.

> *AgroCalc Pro — Fertigation Intelligence*

---

<div align="center">

![Made with Flutter](https://img.shields.io/badge/Made%20with-Flutter-02569B?style=flat-square&logo=flutter)
![Agriculture](https://img.shields.io/badge/Domain-Agriculture-2E7D32?style=flat-square)
![Fertigation](https://img.shields.io/badge/Use%20Case-Fertigation-8BC34A?style=flat-square)

</div>
