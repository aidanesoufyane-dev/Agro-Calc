import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryDark    = Color(0xFF0A2E1A);
  static const Color primary        = Color(0xFF1B5E20);
  static const Color primaryMid     = Color(0xFF2E7D32);
  static const Color primaryLight   = Color(0xFF4CAF50);
  static const Color accent         = Color(0xFF8BC34A);
  static const Color soilBrown      = Color(0xFF4E342E);
  static const Color sandBeige      = Color(0xFFF5F0E8);
  static const Color mistWhite      = Color(0xFFF9FBF7);
  static const Color slateGray      = Color(0xFF546E7A);
  static const Color cardBg         = Color(0xFFFFFFFF);
  static const Color inputBg        = Color(0xFFF1F8E9);
  static const Color inputBorder    = Color(0xFFA5D6A7);
  static const Color divider        = Color(0xFFE8F5E9);
  static const Color errorRed       = Color(0xFFC62828);
  static const Color warningAmber   = Color(0xFFF57F17);
  static const Color successGreen   = Color(0xFF1B5E20);
  
  static const Color bacAStart      = Color(0xFF1B5E20);
  static const Color bacAEnd        = Color(0xFF0A2E1A);
  static const Color bacBStart      = Color(0xFF0D47A1);
  static const Color bacBEnd        = Color(0xFF082280);
  static const Color bacCStart      = Color(0xFFB71C1C);
  static const Color bacCEnd        = Color(0xFF7F0000);
  
  static TextStyle get displayLarge => GoogleFonts.playfairDisplay(fontSize: 32, fontWeight: FontWeight.w700, color: primaryDark, letterSpacing: -0.5);
  static TextStyle get displayMedium => GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.w600, color: primaryDark);
  static TextStyle get titleLarge => GoogleFonts.dmSans(fontSize: 18, fontWeight: FontWeight.w700, color: primaryDark, letterSpacing: 0.2);
  static TextStyle get titleMedium => GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w600, color: primaryDark);
  static TextStyle get appBarTitle => GoogleFonts.playfairDisplay(fontSize: 20, fontWeight: FontWeight.w600, color: primaryDark);
  static TextStyle get bodyLarge => GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w400, color: slateGray);
  static TextStyle get labelLarge => GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: primaryMid, letterSpacing: 0.5);
}
