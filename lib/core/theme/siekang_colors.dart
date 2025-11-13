import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SiEkangColors {
  // Single instantiation only
  static final SiEkangColors _singleton = SiEkangColors._();

  // Returns value of the instantiation
  factory SiEkangColors() => _singleton;

  // Private constructor
  SiEkangColors._();

  // App Theme Light
  static const Color seed = Color(0xFF001D57);
  static const Color primary = Color(0xFF001D57);
  static const Color primaryDark = Color(0xFF001133);
  static const Color colorAccent = Color(0xFFFED136);

  ////////////////////////////////////////////////////////
  // Light
  ////////////////////////////////////////////////////////
  static const Color md_theme_light_primary = Color(0xff465d91);
  static const Color md_theme_light_surfaceTint = Color(0xff465d91);
  static const Color md_theme_light_onPrimary = Color(0xffffffff);
  static const Color md_theme_light_primaryContainer = Color(0xffd9e2ff);
  static const Color md_theme_light_onPrimaryContainer = Color(0xff2e4578);
  static const Color md_theme_light_secondary = Color(0xff4a5c92);
  static const Color md_theme_light_onSecondary = Color(0xffffffff);
  static const Color md_theme_light_secondaryContainer = Color(0xffdbe1ff);
  static const Color md_theme_light_onSecondaryContainer = Color(0xff324578);
  static const Color md_theme_light_tertiary = Color(0xff725c0c);
  static const Color md_theme_light_onTertiary = Color(0xffffffff);
  static const Color md_theme_light_tertiaryContainer = Color(0xffffe086);
  static const Color md_theme_light_onTertiaryContainer = Color(0xff574500);
  static const Color md_theme_light_error = Color(0xffba1a1a);
  static const Color md_theme_light_onError = Color(0xffffffff);
  static const Color md_theme_light_errorContainer = Color(0xffffdad6);
  static const Color md_theme_light_onErrorContainer = Color(0xff93000a);
  static const Color md_theme_light_surface = Color(0xfffaf8ff);
  static const Color md_theme_light_onSurface = Color(0xff1a1b20);
  static const Color md_theme_light_onSurfaceVariant = Color(0xff44464f);
  static const Color md_theme_light_outline = Color(0xff757780);
  static const Color md_theme_light_outlineVariant = Color(0xffc5c6d0);
  static const Color md_theme_light_shadow = Color(0xff000000);
  static const Color md_theme_light_scrim = Color(0xff000000);
  static const Color md_theme_light_inverseSurface = Color(0xff2f3036);
  static const Color md_theme_light_inversePrimary = Color(0xffb0c6ff);
  static const Color md_theme_light_primaryFixed = Color(0xffd9e2ff);
  static const Color md_theme_light_onPrimaryFixed = Color(0xff001944);
  static const Color md_theme_light_primaryFixedDim = Color(0xffb0c6ff);
  static const Color md_theme_light_onPrimaryFixedVariant = Color(0xff2e4578);
  static const Color md_theme_light_secondaryFixed = Color(0xffdbe1ff);
  static const Color md_theme_light_onSecondaryFixed = Color(0xff00174a);
  static const Color md_theme_light_secondaryFixedDim = Color(0xffb3c5ff);
  static const Color md_theme_light_onSecondaryFixedVariant = Color(0xff324578);
  static const Color md_theme_light_tertiaryFixed = Color(0xffffe086);
  static const Color md_theme_light_onTertiaryFixed = Color(0xff231a00);
  static const Color md_theme_light_tertiaryFixedDim = Color(0xffe2c46d);
  static const Color md_theme_light_onTertiaryFixedVariant = Color(0xff574500);
  static const Color md_theme_light_surfaceDim = Color(0xffdad9e0);
  static const Color md_theme_light_surfaceBright = Color(0xfffaf8ff);
  static const Color md_theme_light_surfaceContainerLowest = Color(0xffffffff);
  static const Color md_theme_light_surfaceContainerLow = Color(0xfff4f3fa);
  static const Color md_theme_light_surfaceContainer = Color(0xffeeedf4);
  static const Color md_theme_light_surfaceContainerHigh = Color(0xffe8e7ef);
  static const Color md_theme_light_surfaceContainerHighest = Color(0xffe2e2e9);

  ////////////////////////////////////////////////////////
  // Dark
  ////////////////////////////////////////////////////////
  static const Color md_theme_dark_primary = Color(0xffb0c6ff);
  static const Color md_theme_dark_surfaceTint = Color(0xffb0c6ff);
  static const Color md_theme_dark_onPrimary = Color(0xff142e60);
  static const Color md_theme_dark_primaryContainer = Color(0xff2e4578);
  static const Color md_theme_dark_onPrimaryContainer = Color(0xffd9e2ff);
  static const Color md_theme_dark_secondary = Color(0xffb3c5ff);
  static const Color md_theme_dark_onSecondary = Color(0xff1a2e60);
  static const Color md_theme_dark_secondaryContainer = Color(0xff324578);
  static const Color md_theme_dark_onSecondaryContainer = Color(0xffdbe1ff);
  static const Color md_theme_dark_tertiary = Color(0xffe2c46d);
  static const Color md_theme_dark_onTertiary = Color(0xff3c2f00);
  static const Color md_theme_dark_tertiaryContainer = Color(0xff574500);
  static const Color md_theme_dark_onTertiaryContainer = Color(0xffffe086);
  static const Color md_theme_dark_error = Color(0xffffb4ab);
  static const Color md_theme_dark_onError = Color(0xff690005);
  static const Color md_theme_dark_errorContainer = Color(0xff93000a);
  static const Color md_theme_dark_onErrorContainer = Color(0xffffdad6);
  static const Color md_theme_dark_surface = Color(0xff121318);
  static const Color md_theme_dark_onSurface = Color(0xffe2e2e9);
  static const Color md_theme_dark_onSurfaceVariant = Color(0xffc5c6d0);
  static const Color md_theme_dark_outline = Color(0xff8f9099);
  static const Color md_theme_dark_outlineVariant = Color(0xff44464f);
  static const Color md_theme_dark_shadow = Color(0xff000000);
  static const Color md_theme_dark_scrim = Color(0xff000000);
  static const Color md_theme_dark_inverseSurface = Color(0xffe2e2e9);
  static const Color md_theme_dark_inversePrimary = Color(0xff465d91);
  static const Color md_theme_dark_primaryFixed = Color(0xffd9e2ff);
  static const Color md_theme_dark_onPrimaryFixed = Color(0xff001944);
  static const Color md_theme_dark_primaryFixedDim = Color(0xffb0c6ff);
  static const Color md_theme_dark_onPrimaryFixedVariant = Color(0xff2e4578);
  static const Color md_theme_dark_secondaryFixed = Color(0xffdbe1ff);
  static const Color md_theme_dark_onSecondaryFixed = Color(0xff00174a);
  static const Color md_theme_dark_secondaryFixedDim = Color(0xffb3c5ff);
  static const Color md_theme_dark_onSecondaryFixedVariant = Color(0xff324578);
  static const Color md_theme_dark_tertiaryFixed = Color(0xffffe086);
  static const Color md_theme_dark_onTertiaryFixed = Color(0xff231a00);
  static const Color md_theme_dark_tertiaryFixedDim = Color(0xffe2c46d);
  static const Color md_theme_dark_onTertiaryFixedVariant = Color(0xff574500);
  static const Color md_theme_dark_surfaceDim = Color(0xff121318);
  static const Color md_theme_dark_surfaceBright = Color(0xff38393f);
  static const Color md_theme_dark_surfaceContainerLowest = Color(0xff0c0e13);
  static const Color md_theme_dark_surfaceContainerLow = Color(0xff1a1b20);
  static const Color md_theme_dark_surfaceContainer = Color(0xff1e1f25);
  static const Color md_theme_dark_surfaceContainerHigh = Color(0xff282a2f);
  static const Color md_theme_dark_surfaceContainerHighest = Color(0xff33353a);

  ////////////////////////////////////////////////////////
  // Light Medium Contrast
  ////////////////////////////////////////////////////////
  static const Color md_theme_light_mediumContrast_primary = Color(0xff1b3466);
  static const Color md_theme_light_mediumContrast_surfaceTint =
      Color(0xff465d91);
  static const Color md_theme_light_mediumContrast_onPrimary =
      Color(0xffffffff);
  static const Color md_theme_light_mediumContrast_primaryContainer =
      Color(0xff556ca1);
  static const Color md_theme_light_mediumContrast_onPrimaryContainer =
      Color(0xffffffff);
  static const Color md_theme_light_mediumContrast_secondary =
      Color(0xff203467);
  static const Color md_theme_light_mediumContrast_onSecondary =
      Color(0xffffffff);
  static const Color md_theme_light_mediumContrast_secondaryContainer =
      Color(0xff596ba2);
  static const Color md_theme_light_mediumContrast_onSecondaryContainer =
      Color(0xffffffff);
  static const Color md_theme_light_mediumContrast_tertiary = Color(0xff433400);
  static const Color md_theme_light_mediumContrast_onTertiary =
      Color(0xffffffff);
  static const Color md_theme_light_mediumContrast_tertiaryContainer =
      Color(0xff826b1c);
  static const Color md_theme_light_mediumContrast_onTertiaryContainer =
      Color(0xffffffff);
  static const Color md_theme_light_mediumContrast_error = Color(0xff740006);
  static const Color md_theme_light_mediumContrast_onError = Color(0xffffffff);
  static const Color md_theme_light_mediumContrast_errorContainer =
      Color(0xffcf2c27);
  static const Color md_theme_light_mediumContrast_onErrorContainer =
      Color(0xffffffff);
  static const Color md_theme_light_mediumContrast_surface = Color(0xfffaf8ff);
  static const Color md_theme_light_mediumContrast_onSurface =
      Color(0xff0f1116);
  static const Color md_theme_light_mediumContrast_onSurfaceVariant =
      Color(0xff34363e);
  static const Color md_theme_light_mediumContrast_outline = Color(0xff50525a);
  static const Color md_theme_light_mediumContrast_outlineVariant =
      Color(0xff6b6d75);
  static const Color md_theme_light_mediumContrast_shadow = Color(0xff000000);
  static const Color md_theme_light_mediumContrast_scrim = Color(0xff000000);
  static const Color md_theme_light_mediumContrast_inverseSurface =
      Color(0xff2f3036);
  static const Color md_theme_light_mediumContrast_inversePrimary =
      Color(0xffb0c6ff);
  static const Color md_theme_light_mediumContrast_primaryFixed =
      Color(0xff556ca1);
  static const Color md_theme_light_mediumContrast_onPrimaryFixed =
      Color(0xffffffff);
  static const Color md_theme_light_mediumContrast_primaryFixedDim =
      Color(0xff3c5487);
  static const Color md_theme_light_mediumContrast_onPrimaryFixedVariant =
      Color(0xffffffff);
  static const Color md_theme_light_mediumContrast_secondaryFixed =
      Color(0xff596ba2);
  static const Color md_theme_light_mediumContrast_onSecondaryFixed =
      Color(0xffffffff);
  static const Color md_theme_light_mediumContrast_secondaryFixedDim =
      Color(0xff405388);
  static const Color md_theme_light_mediumContrast_onSecondaryFixedVariant =
      Color(0xffffffff);
  static const Color md_theme_light_mediumContrast_tertiaryFixed =
      Color(0xff826b1c);
  static const Color md_theme_light_mediumContrast_onTertiaryFixed =
      Color(0xffffffff);
  static const Color md_theme_light_mediumContrast_tertiaryFixedDim =
      Color(0xff685201);
  static const Color md_theme_light_mediumContrast_onTertiaryFixedVariant =
      Color(0xffffffff);
  static const Color md_theme_light_mediumContrast_surfaceDim =
      Color(0xffc6c6cd);
  static const Color md_theme_light_mediumContrast_surfaceBright =
      Color(0xfffaf8ff);
  static const Color md_theme_light_mediumContrast_surfaceContainerLowest =
      Color(0xffffffff);
  static const Color md_theme_light_mediumContrast_surfaceContainerLow =
      Color(0xfff4f3fa);
  static const Color md_theme_light_mediumContrast_surfaceContainer =
      Color(0xffe8e7ef);
  static const Color md_theme_light_mediumContrast_surfaceContainerHigh =
      Color(0xffdddce3);
  static const Color md_theme_light_mediumContrast_surfaceContainerHighest =
      Color(0xffd1d1d8);

  ////////////////////////////////////////////////////////
  // Dark Medium Contrast
  ////////////////////////////////////////////////////////
  static const Color md_theme_dark_mediumContrast_primary = Color(0xffd0dcff);
  static const Color md_theme_dark_mediumContrast_surfaceTint =
      Color(0xffb0c6ff);
  static const Color md_theme_dark_mediumContrast_onPrimary = Color(0xff052355);
  static const Color md_theme_dark_mediumContrast_primaryContainer =
      Color(0xff7990c7);
  static const Color md_theme_dark_mediumContrast_onPrimaryContainer =
      Color(0xff000000);
  static const Color md_theme_dark_mediumContrast_secondary = Color(0xffd2dbff);
  static const Color md_theme_dark_mediumContrast_onSecondary =
      Color(0xff0c2255);
  static const Color md_theme_dark_mediumContrast_secondaryContainer =
      Color(0xff7d8fc8);
  static const Color md_theme_dark_mediumContrast_onSecondaryContainer =
      Color(0xff000000);
  static const Color md_theme_dark_mediumContrast_tertiary = Color(0xfff9da80);
  static const Color md_theme_dark_mediumContrast_onTertiary =
      Color(0xff2f2400);
  static const Color md_theme_dark_mediumContrast_tertiaryContainer =
      Color(0xffa88e3d);
  static const Color md_theme_dark_mediumContrast_onTertiaryContainer =
      Color(0xff000000);
  static const Color md_theme_dark_mediumContrast_error = Color(0xffffd2cc);
  static const Color md_theme_dark_mediumContrast_onError = Color(0xff540003);
  static const Color md_theme_dark_mediumContrast_errorContainer =
      Color(0xffff5449);
  static const Color md_theme_dark_mediumContrast_onErrorContainer =
      Color(0xff000000);
  static const Color md_theme_dark_mediumContrast_surface = Color(0xff121318);
  static const Color md_theme_dark_mediumContrast_onSurface = Color(0xffffffff);
  static const Color md_theme_dark_mediumContrast_onSurfaceVariant =
      Color(0xffdbdce6);
  static const Color md_theme_dark_mediumContrast_outline = Color(0xffb0b1bb);
  static const Color md_theme_dark_mediumContrast_outlineVariant =
      Color(0xff8e9099);
  static const Color md_theme_dark_mediumContrast_shadow = Color(0xff000000);
  static const Color md_theme_dark_mediumContrast_scrim = Color(0xff000000);
  static const Color md_theme_dark_mediumContrast_inverseSurface =
      Color(0xffe2e2e9);
  static const Color md_theme_dark_mediumContrast_inversePrimary =
      Color(0xff2f4779);
  static const Color md_theme_dark_mediumContrast_primaryFixed =
      Color(0xffd9e2ff);
  static const Color md_theme_dark_mediumContrast_onPrimaryFixed =
      Color(0xff000f30);
  static const Color md_theme_dark_mediumContrast_primaryFixedDim =
      Color(0xffb0c6ff);
  static const Color md_theme_dark_mediumContrast_onPrimaryFixedVariant =
      Color(0xff1b3466);
  static const Color md_theme_dark_mediumContrast_secondaryFixed =
      Color(0xffdbe1ff);
  static const Color md_theme_dark_mediumContrast_onSecondaryFixed =
      Color(0xff000e34);
  static const Color md_theme_dark_mediumContrast_secondaryFixedDim =
      Color(0xffb3c5ff);
  static const Color md_theme_dark_mediumContrast_onSecondaryFixedVariant =
      Color(0xff203467);
  static const Color md_theme_dark_mediumContrast_tertiaryFixed =
      Color(0xffffe086);
  static const Color md_theme_dark_mediumContrast_onTertiaryFixed =
      Color(0xff171000);
  static const Color md_theme_dark_mediumContrast_tertiaryFixedDim =
      Color(0xffe2c46d);
  static const Color md_theme_dark_mediumContrast_onTertiaryFixedVariant =
      Color(0xff433400);
  static const Color md_theme_dark_mediumContrast_surfaceDim =
      Color(0xff121318);
  static const Color md_theme_dark_mediumContrast_surfaceBright =
      Color(0xff43444a);
  static const Color md_theme_dark_mediumContrast_surfaceContainerLowest =
      Color(0xff06070c);
  static const Color md_theme_dark_mediumContrast_surfaceContainerLow =
      Color(0xff1c1d23);
  static const Color md_theme_dark_mediumContrast_surfaceContainer =
      Color(0xff26282d);
  static const Color md_theme_dark_mediumContrast_surfaceContainerHigh =
      Color(0xff313238);
  static const Color md_theme_dark_mediumContrast_surfaceContainerHighest =
      Color(0xff3c3d43);

  ////////////////////////////////////////////////////////
  // Light High Contrast
  ////////////////////////////////////////////////////////
  static const Color md_theme_light_highContrast_primary = Color(0xff0f2a5c);
  static const Color md_theme_light_highContrast_surfaceTint =
      Color(0xff465d91);
  static const Color md_theme_light_highContrast_onPrimary = Color(0xffffffff);
  static const Color md_theme_light_highContrast_primaryContainer =
      Color(0xff30487b);
  static const Color md_theme_light_highContrast_onPrimaryContainer =
      Color(0xffffffff);
  static const Color md_theme_light_highContrast_secondary = Color(0xff14295c);
  static const Color md_theme_light_highContrast_onSecondary =
      Color(0xffffffff);
  static const Color md_theme_light_highContrast_secondaryContainer =
      Color(0xff34477b);
  static const Color md_theme_light_highContrast_onSecondaryContainer =
      Color(0xffffffff);
  static const Color md_theme_light_highContrast_tertiary = Color(0xff372b00);
  static const Color md_theme_light_highContrast_onTertiary = Color(0xffffffff);
  static const Color md_theme_light_highContrast_tertiaryContainer =
      Color(0xff5a4700);
  static const Color md_theme_light_highContrast_onTertiaryContainer =
      Color(0xffffffff);
  static const Color md_theme_light_highContrast_error = Color(0xff600004);
  static const Color md_theme_light_highContrast_onError = Color(0xffffffff);
  static const Color md_theme_light_highContrast_errorContainer =
      Color(0xff98000a);
  static const Color md_theme_light_highContrast_onErrorContainer =
      Color(0xffffffff);
  static const Color md_theme_light_highContrast_surface = Color(0xfffaf8ff);
  static const Color md_theme_light_highContrast_onSurface = Color(0xff000000);
  static const Color md_theme_light_highContrast_onSurfaceVariant =
      Color(0xff000000);
  static const Color md_theme_light_highContrast_outline = Color(0xff2a2c33);
  static const Color md_theme_light_highContrast_outlineVariant =
      Color(0xff474951);
  static const Color md_theme_light_highContrast_shadow = Color(0xff000000);
  static const Color md_theme_light_highContrast_scrim = Color(0xff000000);
  static const Color md_theme_light_highContrast_inverseSurface =
      Color(0xff2f3036);
  static const Color md_theme_light_highContrast_inversePrimary =
      Color(0xffb0c6ff);
  static const Color md_theme_light_highContrast_primaryFixed =
      Color(0xff30487b);
  static const Color md_theme_light_highContrast_onPrimaryFixed =
      Color(0xffffffff);
  static const Color md_theme_light_highContrast_primaryFixedDim =
      Color(0xff173162);
  static const Color md_theme_light_highContrast_onPrimaryFixedVariant =
      Color(0xffffffff);
  static const Color md_theme_light_highContrast_secondaryFixed =
      Color(0xff34477b);
  static const Color md_theme_light_highContrast_onSecondaryFixed =
      Color(0xffffffff);
  static const Color md_theme_light_highContrast_secondaryFixedDim =
      Color(0xff1c3063);
  static const Color md_theme_light_highContrast_onSecondaryFixedVariant =
      Color(0xffffffff);
  static const Color md_theme_light_highContrast_tertiaryFixed =
      Color(0xff5a4700);
  static const Color md_theme_light_highContrast_onTertiaryFixed =
      Color(0xffffffff);
  static const Color md_theme_light_highContrast_tertiaryFixedDim =
      Color(0xff3f3100);
  static const Color md_theme_light_highContrast_onTertiaryFixedVariant =
      Color(0xffffffff);
  static const Color md_theme_light_highContrast_surfaceDim = Color(0xffb8b8bf);
  static const Color md_theme_light_highContrast_surfaceBright =
      Color(0xfffaf8ff);
  static const Color md_theme_light_highContrast_surfaceContainerLowest =
      Color(0xffffffff);
  static const Color md_theme_light_highContrast_surfaceContainerLow =
      Color(0xfff1f0f7);
  static const Color md_theme_light_highContrast_surfaceContainer =
      Color(0xffe2e2e9);
  static const Color md_theme_light_highContrast_surfaceContainerHigh =
      Color(0xffd4d4db);
  static const Color md_theme_light_highContrast_surfaceContainerHighest =
      Color(0xffc6c6cd);

  ////////////////////////////////////////////////////////
  // Dark High Contrast
  ////////////////////////////////////////////////////////
  static const Color md_theme_dark_highContrast_primary = Color(0xffecefff);
  static const Color md_theme_dark_highContrast_surfaceTint = Color(0xffb0c6ff);
  static const Color md_theme_dark_highContrast_onPrimary = Color(0xff000000);
  static const Color md_theme_dark_highContrast_primaryContainer =
      Color(0xffabc2fd);
  static const Color md_theme_dark_highContrast_onPrimaryContainer =
      Color(0xff000a24);
  static const Color md_theme_dark_highContrast_secondary = Color(0xffedefff);
  static const Color md_theme_dark_highContrast_onSecondary = Color(0xff000000);
  static const Color md_theme_dark_highContrast_secondaryContainer =
      Color(0xffaec1fd);
  static const Color md_theme_dark_highContrast_onSecondaryContainer =
      Color(0xff000927);
  static const Color md_theme_dark_highContrast_tertiary = Color(0xffffefc8);
  static const Color md_theme_dark_highContrast_onTertiary = Color(0xff000000);
  static const Color md_theme_dark_highContrast_tertiaryContainer =
      Color(0xffddc069);
  static const Color md_theme_dark_highContrast_onTertiaryContainer =
      Color(0xff100b00);
  static const Color md_theme_dark_highContrast_error = Color(0xffffece9);
  static const Color md_theme_dark_highContrast_onError = Color(0xff000000);
  static const Color md_theme_dark_highContrast_errorContainer =
      Color(0xffffaea4);
  static const Color md_theme_dark_highContrast_onErrorContainer =
      Color(0xff220001);
  static const Color md_theme_dark_highContrast_surface = Color(0xff121318);
  static const Color md_theme_dark_highContrast_onSurface = Color(0xffffffff);
  static const Color md_theme_dark_highContrast_onSurfaceVariant =
      Color(0xffffffff);
  static const Color md_theme_dark_highContrast_outline = Color(0xffefeff9);
  static const Color md_theme_dark_highContrast_outlineVariant =
      Color(0xffc1c2cc);
  static const Color md_theme_dark_highContrast_shadow = Color(0xff000000);
  static const Color md_theme_dark_highContrast_scrim = Color(0xff000000);
  static const Color md_theme_dark_highContrast_inverseSurface =
      Color(0xffe2e2e9);
  static const Color md_theme_dark_highContrast_inversePrimary =
      Color(0xff2f4779);
  static const Color md_theme_dark_highContrast_primaryFixed =
      Color(0xffd9e2ff);
  static const Color md_theme_dark_highContrast_onPrimaryFixed =
      Color(0xff000000);
  static const Color md_theme_dark_highContrast_primaryFixedDim =
      Color(0xffb0c6ff);
  static const Color md_theme_dark_highContrast_onPrimaryFixedVariant =
      Color(0xff000f30);
  static const Color md_theme_dark_highContrast_secondaryFixed =
      Color(0xffdbe1ff);
  static const Color md_theme_dark_highContrast_onSecondaryFixed =
      Color(0xff000000);
  static const Color md_theme_dark_highContrast_secondaryFixedDim =
      Color(0xffb3c5ff);
  static const Color md_theme_dark_highContrast_onSecondaryFixedVariant =
      Color(0xff000e34);
  static const Color md_theme_dark_highContrast_tertiaryFixed =
      Color(0xffffe086);
  static const Color md_theme_dark_highContrast_onTertiaryFixed =
      Color(0xff000000);
  static const Color md_theme_dark_highContrast_tertiaryFixedDim =
      Color(0xffe2c46d);
  static const Color md_theme_dark_highContrast_onTertiaryFixedVariant =
      Color(0xff171000);
  static const Color md_theme_dark_highContrast_surfaceDim = Color(0xff121318);
  static const Color md_theme_dark_highContrast_surfaceBright =
      Color(0xff4f5056);
  static const Color md_theme_dark_highContrast_surfaceContainerLowest =
      Color(0xff000000);
  static const Color md_theme_dark_highContrast_surfaceContainerLow =
      Color(0xff1e1f25);
  static const Color md_theme_dark_highContrast_surfaceContainer =
      Color(0xff2f3036);
  static const Color md_theme_dark_highContrast_surfaceContainerHigh =
      Color(0xff3a3b41);
  static const Color md_theme_dark_highContrast_surfaceContainerHighest =
      Color(0xff45464c);

  ////////////////////////////////////////////////////////
  // Palette
  ////////////////////////////////////////////////////////
  // Default Palette
  static const Color defaultLight = Color(0xFFE2E2E2);
  static const Color defaultDark = Color(0xFF2E2E2E);

  // Quiz Palette
  static const Color quizItemSelectedStroke = Color(0xFF0073D8);
  static const Color quizItemSelectedTextColor = Color(0xFF207EC3);

  // Other Palette
  static const Color white = Color(0xFFFFFFFF);
  static const Color yellow = Color(0xFF816C06);
  static const Color red = Color(0xFF980100);
  static const Color blue = Color(0xFF003988);
  static const Color green = Color(0xFF17601A);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
