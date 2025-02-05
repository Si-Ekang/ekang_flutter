import 'package:ekang_flutter/core/widgets/widgets.dart';
import "package:adaptive_theme/adaptive_theme.dart";
class SiEkangTheme {
  final TextTheme textTheme;

  const SiEkangTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: SiEkangColors.md_theme_light_primary,
      surfaceTint: SiEkangColors.md_theme_light_surfaceTint,
      onPrimary: SiEkangColors.md_theme_light_onPrimary,
      primaryContainer: SiEkangColors.md_theme_light_primaryContainer,
      onPrimaryContainer: SiEkangColors.md_theme_light_onPrimaryContainer,
      secondary: SiEkangColors.md_theme_light_secondary,
      onSecondary: SiEkangColors.md_theme_light_onSecondary,
      secondaryContainer: SiEkangColors.md_theme_light_secondaryContainer,
      onSecondaryContainer: SiEkangColors.md_theme_light_onSecondaryContainer,
      tertiary: SiEkangColors.md_theme_light_tertiary,
      onTertiary: SiEkangColors.md_theme_light_onTertiary,
      tertiaryContainer: SiEkangColors.md_theme_light_tertiaryContainer,
      onTertiaryContainer: SiEkangColors.md_theme_light_onTertiaryContainer,
      error: SiEkangColors.md_theme_light_error,
      onError: SiEkangColors.md_theme_light_onError,
      errorContainer: SiEkangColors.md_theme_light_errorContainer,
      onErrorContainer: SiEkangColors.md_theme_light_onErrorContainer,
      surface: SiEkangColors.md_theme_light_surface,
      onSurface: SiEkangColors.md_theme_light_onSurface,
      onSurfaceVariant: SiEkangColors.md_theme_light_onSurfaceVariant,
      outline: SiEkangColors.md_theme_light_outline,
      outlineVariant: SiEkangColors.md_theme_light_outlineVariant,
      shadow: SiEkangColors.md_theme_light_shadow,
      scrim: SiEkangColors.md_theme_light_scrim,
      inverseSurface: SiEkangColors.md_theme_light_inverseSurface,
      inversePrimary: SiEkangColors.md_theme_light_inversePrimary,
      primaryFixed: SiEkangColors.md_theme_light_primaryFixed,
      onPrimaryFixed: SiEkangColors.md_theme_light_onPrimaryFixed,
      primaryFixedDim: SiEkangColors.md_theme_light_primaryFixedDim,
      onPrimaryFixedVariant: SiEkangColors.md_theme_light_onPrimaryFixedVariant,
      secondaryFixed: SiEkangColors.md_theme_light_secondaryFixed,
      onSecondaryFixed: SiEkangColors.md_theme_light_onSecondaryFixed,
      secondaryFixedDim: SiEkangColors.md_theme_light_secondaryFixedDim,
      onSecondaryFixedVariant:
          SiEkangColors.md_theme_light_onSecondaryFixedVariant,
      tertiaryFixed: SiEkangColors.md_theme_light_tertiaryFixed,
      onTertiaryFixed: SiEkangColors.md_theme_light_onTertiaryFixed,
      tertiaryFixedDim: SiEkangColors.md_theme_light_tertiaryFixedDim,
      onTertiaryFixedVariant:
          SiEkangColors.md_theme_light_onTertiaryFixedVariant,
      surfaceDim: SiEkangColors.md_theme_light_surfaceDim,
      surfaceBright: SiEkangColors.md_theme_light_surfaceBright,
      surfaceContainerLowest:
          SiEkangColors.md_theme_light_surfaceContainerLowest,
      surfaceContainerLow: SiEkangColors.md_theme_light_surfaceContainerLow,
      surfaceContainer: SiEkangColors.md_theme_light_surfaceContainer,
      surfaceContainerHigh: SiEkangColors.md_theme_light_surfaceContainerHigh,
      surfaceContainerHighest:
          SiEkangColors.md_theme_light_surfaceContainerHighest,
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: SiEkangColors.md_theme_light_mediumContrast_primary,
      surfaceTint: SiEkangColors.md_theme_light_mediumContrast_surfaceTint,
      onPrimary: SiEkangColors.md_theme_light_mediumContrast_onPrimary,
      primaryContainer:
          SiEkangColors.md_theme_light_mediumContrast_primaryContainer,
      onPrimaryContainer:
          SiEkangColors.md_theme_light_mediumContrast_onPrimaryContainer,
      secondary: SiEkangColors.md_theme_light_mediumContrast_secondary,
      onSecondary: SiEkangColors.md_theme_light_mediumContrast_onSecondary,
      secondaryContainer:
          SiEkangColors.md_theme_light_mediumContrast_secondaryContainer,
      onSecondaryContainer:
          SiEkangColors.md_theme_light_mediumContrast_onSecondaryContainer,
      tertiary: SiEkangColors.md_theme_light_mediumContrast_tertiary,
      onTertiary: SiEkangColors.md_theme_light_mediumContrast_onTertiary,
      tertiaryContainer:
          SiEkangColors.md_theme_light_mediumContrast_tertiaryContainer,
      onTertiaryContainer:
          SiEkangColors.md_theme_light_mediumContrast_onTertiaryContainer,
      error: SiEkangColors.md_theme_light_mediumContrast_error,
      onError: SiEkangColors.md_theme_light_mediumContrast_onError,
      errorContainer:
          SiEkangColors.md_theme_light_mediumContrast_errorContainer,
      onErrorContainer:
          SiEkangColors.md_theme_light_mediumContrast_onErrorContainer,
      surface: SiEkangColors.md_theme_light_mediumContrast_surface,
      onSurface: SiEkangColors.md_theme_light_mediumContrast_onSurface,
      onSurfaceVariant:
          SiEkangColors.md_theme_light_mediumContrast_onSurfaceVariant,
      outline: SiEkangColors.md_theme_light_mediumContrast_outline,
      outlineVariant:
          SiEkangColors.md_theme_light_mediumContrast_outlineVariant,
      shadow: SiEkangColors.md_theme_light_mediumContrast_shadow,
      scrim: SiEkangColors.md_theme_light_mediumContrast_scrim,
      inverseSurface:
          SiEkangColors.md_theme_light_mediumContrast_inverseSurface,
      inversePrimary:
          SiEkangColors.md_theme_light_mediumContrast_inversePrimary,
      primaryFixed: SiEkangColors.md_theme_light_mediumContrast_primaryFixed,
      onPrimaryFixed:
          SiEkangColors.md_theme_light_mediumContrast_onPrimaryFixed,
      primaryFixedDim:
          SiEkangColors.md_theme_light_mediumContrast_primaryFixedDim,
      onPrimaryFixedVariant:
          SiEkangColors.md_theme_light_mediumContrast_onPrimaryFixedVariant,
      secondaryFixed:
          SiEkangColors.md_theme_light_mediumContrast_secondaryFixed,
      onSecondaryFixed:
          SiEkangColors.md_theme_light_mediumContrast_onSecondaryFixed,
      secondaryFixedDim:
          SiEkangColors.md_theme_light_mediumContrast_secondaryFixedDim,
      onSecondaryFixedVariant:
          SiEkangColors.md_theme_light_mediumContrast_onSecondaryFixedVariant,
      tertiaryFixed: SiEkangColors.md_theme_light_mediumContrast_tertiaryFixed,
      onTertiaryFixed:
          SiEkangColors.md_theme_light_mediumContrast_onTertiaryFixed,
      tertiaryFixedDim:
          SiEkangColors.md_theme_light_mediumContrast_tertiaryFixedDim,
      onTertiaryFixedVariant:
          SiEkangColors.md_theme_light_mediumContrast_onTertiaryFixedVariant,
      surfaceDim: SiEkangColors.md_theme_light_mediumContrast_surfaceDim,
      surfaceBright: SiEkangColors.md_theme_light_mediumContrast_surfaceBright,
      surfaceContainerLowest:
          SiEkangColors.md_theme_light_mediumContrast_surfaceContainerLowest,
      surfaceContainerLow:
          SiEkangColors.md_theme_light_mediumContrast_surfaceContainerLow,
      surfaceContainer:
          SiEkangColors.md_theme_light_mediumContrast_surfaceContainer,
      surfaceContainerHigh:
          SiEkangColors.md_theme_light_mediumContrast_surfaceContainerHigh,
      surfaceContainerHighest:
          SiEkangColors.md_theme_light_mediumContrast_surfaceContainerHighest,
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: SiEkangColors.md_theme_light_highContrast_primary,
      surfaceTint: SiEkangColors.md_theme_light_highContrast_surfaceTint,
      onPrimary: SiEkangColors.md_theme_light_highContrast_onPrimary,
      primaryContainer:
          SiEkangColors.md_theme_light_highContrast_primaryContainer,
      onPrimaryContainer:
          SiEkangColors.md_theme_light_highContrast_onPrimaryContainer,
      secondary: SiEkangColors.md_theme_light_highContrast_secondary,
      onSecondary: SiEkangColors.md_theme_light_highContrast_onSecondary,
      secondaryContainer:
          SiEkangColors.md_theme_light_highContrast_secondaryContainer,
      onSecondaryContainer:
          SiEkangColors.md_theme_light_highContrast_onSecondaryContainer,
      tertiary: SiEkangColors.md_theme_light_highContrast_tertiary,
      onTertiary: SiEkangColors.md_theme_light_highContrast_onTertiary,
      tertiaryContainer:
          SiEkangColors.md_theme_light_highContrast_tertiaryContainer,
      onTertiaryContainer:
          SiEkangColors.md_theme_light_highContrast_onTertiaryContainer,
      error: SiEkangColors.md_theme_light_highContrast_error,
      onError: SiEkangColors.md_theme_light_highContrast_onError,
      errorContainer: SiEkangColors.md_theme_light_highContrast_errorContainer,
      onErrorContainer:
          SiEkangColors.md_theme_light_highContrast_onErrorContainer,
      surface: SiEkangColors.md_theme_light_highContrast_surface,
      onSurface: SiEkangColors.md_theme_light_highContrast_onSurface,
      onSurfaceVariant:
          SiEkangColors.md_theme_light_highContrast_onSurfaceVariant,
      outline: SiEkangColors.md_theme_light_highContrast_outline,
      outlineVariant: SiEkangColors.md_theme_light_highContrast_outlineVariant,
      shadow: SiEkangColors.md_theme_light_highContrast_shadow,
      scrim: SiEkangColors.md_theme_light_highContrast_scrim,
      inverseSurface: SiEkangColors.md_theme_light_highContrast_inverseSurface,
      inversePrimary: SiEkangColors.md_theme_light_highContrast_inversePrimary,
      primaryFixed: SiEkangColors.md_theme_light_highContrast_primaryFixed,
      onPrimaryFixed: SiEkangColors.md_theme_light_highContrast_onPrimaryFixed,
      primaryFixedDim:
          SiEkangColors.md_theme_light_highContrast_primaryFixedDim,
      onPrimaryFixedVariant:
          SiEkangColors.md_theme_light_highContrast_onPrimaryFixedVariant,
      secondaryFixed: SiEkangColors.md_theme_light_highContrast_secondaryFixed,
      onSecondaryFixed:
          SiEkangColors.md_theme_light_highContrast_onSecondaryFixed,
      secondaryFixedDim:
          SiEkangColors.md_theme_light_highContrast_secondaryFixedDim,
      onSecondaryFixedVariant:
          SiEkangColors.md_theme_light_highContrast_onSecondaryFixedVariant,
      tertiaryFixed: SiEkangColors.md_theme_light_highContrast_tertiaryFixed,
      onTertiaryFixed:
          SiEkangColors.md_theme_light_highContrast_onTertiaryFixed,
      tertiaryFixedDim:
          SiEkangColors.md_theme_light_highContrast_tertiaryFixedDim,
      onTertiaryFixedVariant:
          SiEkangColors.md_theme_light_highContrast_onTertiaryFixedVariant,
      surfaceDim: SiEkangColors.md_theme_light_highContrast_surfaceDim,
      surfaceBright: SiEkangColors.md_theme_light_highContrast_surfaceBright,
      surfaceContainerLowest:
          SiEkangColors.md_theme_light_highContrast_surfaceContainerLowest,
      surfaceContainerLow:
          SiEkangColors.md_theme_light_highContrast_surfaceContainerLow,
      surfaceContainer:
          SiEkangColors.md_theme_light_highContrast_surfaceContainer,
      surfaceContainerHigh:
          SiEkangColors.md_theme_light_highContrast_surfaceContainerHigh,
      surfaceContainerHighest:
          SiEkangColors.md_theme_light_highContrast_surfaceContainerHighest,
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: SiEkangColors.md_theme_dark_primary,
      surfaceTint: SiEkangColors.md_theme_dark_surfaceTint,
      onPrimary: SiEkangColors.md_theme_dark_onPrimary,
      primaryContainer: SiEkangColors.md_theme_dark_primaryContainer,
      onPrimaryContainer: SiEkangColors.md_theme_dark_onPrimaryContainer,
      secondary: SiEkangColors.md_theme_dark_secondary,
      onSecondary: SiEkangColors.md_theme_dark_onSecondary,
      secondaryContainer: SiEkangColors.md_theme_dark_secondaryContainer,
      onSecondaryContainer: SiEkangColors.md_theme_dark_onSecondaryContainer,
      tertiary: SiEkangColors.md_theme_dark_tertiary,
      onTertiary: SiEkangColors.md_theme_dark_onTertiary,
      tertiaryContainer: SiEkangColors.md_theme_dark_tertiaryContainer,
      onTertiaryContainer: SiEkangColors.md_theme_dark_onTertiaryContainer,
      error: SiEkangColors.md_theme_dark_error,
      onError: SiEkangColors.md_theme_dark_onError,
      errorContainer: SiEkangColors.md_theme_dark_errorContainer,
      onErrorContainer: SiEkangColors.md_theme_dark_onErrorContainer,
      surface: SiEkangColors.md_theme_dark_surface,
      onSurface: SiEkangColors.md_theme_dark_onSurface,
      onSurfaceVariant: SiEkangColors.md_theme_dark_onSurfaceVariant,
      outline: SiEkangColors.md_theme_dark_outline,
      outlineVariant: SiEkangColors.md_theme_dark_outlineVariant,
      shadow: SiEkangColors.md_theme_dark_shadow,
      scrim: SiEkangColors.md_theme_dark_scrim,
      inverseSurface: SiEkangColors.md_theme_dark_inverseSurface,
      inversePrimary: SiEkangColors.md_theme_dark_inversePrimary,
      primaryFixed: SiEkangColors.md_theme_dark_primaryFixed,
      onPrimaryFixed: SiEkangColors.md_theme_dark_onPrimaryFixed,
      primaryFixedDim: SiEkangColors.md_theme_dark_primaryFixedDim,
      onPrimaryFixedVariant: SiEkangColors.md_theme_dark_onPrimaryFixedVariant,
      secondaryFixed: SiEkangColors.md_theme_dark_secondaryFixed,
      onSecondaryFixed: SiEkangColors.md_theme_dark_onSecondaryFixed,
      secondaryFixedDim: SiEkangColors.md_theme_dark_secondaryFixedDim,
      onSecondaryFixedVariant:
          SiEkangColors.md_theme_dark_onSecondaryFixedVariant,
      tertiaryFixed: SiEkangColors.md_theme_dark_tertiaryFixed,
      onTertiaryFixed: SiEkangColors.md_theme_dark_onTertiaryFixed,
      tertiaryFixedDim: SiEkangColors.md_theme_dark_tertiaryFixedDim,
      onTertiaryFixedVariant:
          SiEkangColors.md_theme_dark_onTertiaryFixedVariant,
      surfaceDim: SiEkangColors.md_theme_dark_surfaceDim,
      surfaceBright: SiEkangColors.md_theme_dark_surfaceBright,
      surfaceContainerLowest:
          SiEkangColors.md_theme_dark_surfaceContainerLowest,
      surfaceContainerLow: SiEkangColors.md_theme_dark_surfaceContainerLow,
      surfaceContainer: SiEkangColors.md_theme_dark_surfaceContainer,
      surfaceContainerHigh: SiEkangColors.md_theme_dark_surfaceContainerHigh,
      surfaceContainerHighest:
          SiEkangColors.md_theme_dark_surfaceContainerHighest,
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: SiEkangColors.md_theme_dark_mediumContrast_primary,
      surfaceTint: SiEkangColors.md_theme_dark_mediumContrast_surfaceTint,
      onPrimary: SiEkangColors.md_theme_dark_mediumContrast_onPrimary,
      primaryContainer:
          SiEkangColors.md_theme_dark_mediumContrast_primaryContainer,
      onPrimaryContainer:
          SiEkangColors.md_theme_dark_mediumContrast_onPrimaryContainer,
      secondary: SiEkangColors.md_theme_dark_mediumContrast_secondary,
      onSecondary: SiEkangColors.md_theme_dark_mediumContrast_onSecondary,
      secondaryContainer:
          SiEkangColors.md_theme_dark_mediumContrast_secondaryContainer,
      onSecondaryContainer:
          SiEkangColors.md_theme_dark_mediumContrast_onSecondaryContainer,
      tertiary: SiEkangColors.md_theme_dark_mediumContrast_tertiary,
      onTertiary: SiEkangColors.md_theme_dark_mediumContrast_onTertiary,
      tertiaryContainer:
          SiEkangColors.md_theme_dark_mediumContrast_tertiaryContainer,
      onTertiaryContainer:
          SiEkangColors.md_theme_dark_mediumContrast_onTertiaryContainer,
      error: SiEkangColors.md_theme_dark_mediumContrast_error,
      onError: SiEkangColors.md_theme_dark_mediumContrast_onError,
      errorContainer: SiEkangColors.md_theme_dark_mediumContrast_errorContainer,
      onErrorContainer:
          SiEkangColors.md_theme_dark_mediumContrast_onErrorContainer,
      surface: SiEkangColors.md_theme_dark_mediumContrast_surface,
      onSurface: SiEkangColors.md_theme_dark_mediumContrast_onSurface,
      onSurfaceVariant:
          SiEkangColors.md_theme_dark_mediumContrast_onSurfaceVariant,
      outline: SiEkangColors.md_theme_dark_mediumContrast_outline,
      outlineVariant: SiEkangColors.md_theme_dark_mediumContrast_outlineVariant,
      shadow: SiEkangColors.md_theme_dark_mediumContrast_shadow,
      scrim: SiEkangColors.md_theme_dark_mediumContrast_scrim,
      inverseSurface: SiEkangColors.md_theme_dark_mediumContrast_inverseSurface,
      inversePrimary: SiEkangColors.md_theme_dark_mediumContrast_inversePrimary,
      primaryFixed: SiEkangColors.md_theme_dark_mediumContrast_primaryFixed,
      onPrimaryFixed: SiEkangColors.md_theme_dark_mediumContrast_onPrimaryFixed,
      primaryFixedDim:
          SiEkangColors.md_theme_dark_mediumContrast_primaryFixedDim,
      onPrimaryFixedVariant:
          SiEkangColors.md_theme_dark_mediumContrast_onPrimaryFixedVariant,
      secondaryFixed: SiEkangColors.md_theme_dark_mediumContrast_secondaryFixed,
      onSecondaryFixed:
          SiEkangColors.md_theme_dark_mediumContrast_onSecondaryFixed,
      secondaryFixedDim:
          SiEkangColors.md_theme_dark_mediumContrast_secondaryFixedDim,
      onSecondaryFixedVariant:
          SiEkangColors.md_theme_dark_mediumContrast_onSecondaryFixedVariant,
      tertiaryFixed: SiEkangColors.md_theme_dark_mediumContrast_tertiaryFixed,
      onTertiaryFixed:
          SiEkangColors.md_theme_dark_mediumContrast_onTertiaryFixed,
      tertiaryFixedDim:
          SiEkangColors.md_theme_dark_mediumContrast_tertiaryFixedDim,
      onTertiaryFixedVariant:
          SiEkangColors.md_theme_dark_mediumContrast_onTertiaryFixedVariant,
      surfaceDim: SiEkangColors.md_theme_dark_mediumContrast_surfaceDim,
      surfaceBright: SiEkangColors.md_theme_dark_mediumContrast_surfaceBright,
      surfaceContainerLowest:
          SiEkangColors.md_theme_dark_mediumContrast_surfaceContainerLowest,
      surfaceContainerLow:
          SiEkangColors.md_theme_dark_mediumContrast_surfaceContainerLow,
      surfaceContainer:
          SiEkangColors.md_theme_dark_mediumContrast_surfaceContainer,
      surfaceContainerHigh:
          SiEkangColors.md_theme_dark_mediumContrast_surfaceContainerHigh,
      surfaceContainerHighest:
          SiEkangColors.md_theme_dark_mediumContrast_surfaceContainerHighest,
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: SiEkangColors.md_theme_dark_highContrast_primary,
      surfaceTint: SiEkangColors.md_theme_dark_highContrast_surfaceTint,
      onPrimary: SiEkangColors.md_theme_dark_highContrast_onPrimary,
      primaryContainer:
          SiEkangColors.md_theme_dark_highContrast_primaryContainer,
      onPrimaryContainer:
          SiEkangColors.md_theme_dark_highContrast_onPrimaryContainer,
      secondary: SiEkangColors.md_theme_dark_highContrast_secondary,
      onSecondary: SiEkangColors.md_theme_dark_highContrast_onSecondary,
      secondaryContainer:
          SiEkangColors.md_theme_dark_highContrast_secondaryContainer,
      onSecondaryContainer:
          SiEkangColors.md_theme_dark_highContrast_onSecondaryContainer,
      tertiary: SiEkangColors.md_theme_dark_highContrast_tertiary,
      onTertiary: SiEkangColors.md_theme_dark_highContrast_onTertiary,
      tertiaryContainer:
          SiEkangColors.md_theme_dark_highContrast_tertiaryContainer,
      onTertiaryContainer:
          SiEkangColors.md_theme_dark_highContrast_onTertiaryContainer,
      error: SiEkangColors.md_theme_dark_highContrast_error,
      onError: SiEkangColors.md_theme_dark_highContrast_onError,
      errorContainer: SiEkangColors.md_theme_dark_highContrast_errorContainer,
      onErrorContainer:
          SiEkangColors.md_theme_dark_highContrast_onErrorContainer,
      surface: SiEkangColors.md_theme_dark_highContrast_surface,
      onSurface: SiEkangColors.md_theme_dark_highContrast_onSurface,
      onSurfaceVariant:
          SiEkangColors.md_theme_dark_highContrast_onSurfaceVariant,
      outline: SiEkangColors.md_theme_dark_highContrast_outline,
      outlineVariant: SiEkangColors.md_theme_dark_highContrast_outlineVariant,
      shadow: SiEkangColors.md_theme_dark_highContrast_shadow,
      scrim: SiEkangColors.md_theme_dark_highContrast_scrim,
      inverseSurface: SiEkangColors.md_theme_dark_highContrast_inverseSurface,
      inversePrimary: SiEkangColors.md_theme_dark_highContrast_inversePrimary,
      primaryFixed: SiEkangColors.md_theme_dark_highContrast_primaryFixed,
      onPrimaryFixed: SiEkangColors.md_theme_dark_highContrast_onPrimaryFixed,
      primaryFixedDim: SiEkangColors.md_theme_dark_highContrast_primaryFixedDim,
      onPrimaryFixedVariant:
          SiEkangColors.md_theme_dark_highContrast_onPrimaryFixedVariant,
      secondaryFixed: SiEkangColors.md_theme_dark_highContrast_secondaryFixed,
      onSecondaryFixed:
          SiEkangColors.md_theme_dark_highContrast_onSecondaryFixed,
      secondaryFixedDim:
          SiEkangColors.md_theme_dark_highContrast_secondaryFixedDim,
      onSecondaryFixedVariant:
          SiEkangColors.md_theme_dark_highContrast_onSecondaryFixedVariant,
      tertiaryFixed: SiEkangColors.md_theme_dark_highContrast_tertiaryFixed,
      onTertiaryFixed: SiEkangColors.md_theme_dark_highContrast_onTertiaryFixed,
      tertiaryFixedDim:
          SiEkangColors.md_theme_dark_highContrast_tertiaryFixedDim,
      onTertiaryFixedVariant:
          SiEkangColors.md_theme_dark_highContrast_onTertiaryFixedVariant,
      surfaceDim: SiEkangColors.md_theme_dark_highContrast_surfaceDim,
      surfaceBright: SiEkangColors.md_theme_dark_highContrast_surfaceBright,
      surfaceContainerLowest:
          SiEkangColors.md_theme_dark_highContrast_surfaceContainerLowest,
      surfaceContainerLow:
          SiEkangColors.md_theme_dark_highContrast_surfaceContainerLow,
      surfaceContainer:
          SiEkangColors.md_theme_dark_highContrast_surfaceContainer,
      surfaceContainerHigh:
          SiEkangColors.md_theme_dark_highContrast_surfaceContainerHigh,
      surfaceContainerHighest:
          SiEkangColors.md_theme_dark_highContrast_surfaceContainerHighest,
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];

  static bool isDarkTheme(BuildContext context) {
    return AdaptiveThemeMode.dark == AdaptiveTheme.of(context).mode;
  }
}
