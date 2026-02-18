import 'package:flutter/material.dart';

/// Extensions on [Color] for real-world utility operations.
extension ColorUtils on Color {
  // ─── Brightness ──────────────────────────────────────────────────────────────

  /// Returns `true` if this color is perceived as light.
  /// Uses the WCAG relative luminance formula.
  bool get isLight => luminance > 0.179;

  /// Returns `true` if this color is perceived as dark.
  bool get isDark => !isLight;

  /// Returns the WCAG relative luminance of this color (0..1).
  double get luminance {
    double linearize(double c) {
      return c <= 0.03928
          ? c / 12.92
          : ((c + 0.055) / 1.055) * ((c + 0.055) / 1.055);
    }

    final r = linearize((this.r * 255.0).round().clamp(0, 255) / 255);
    final g = linearize((this.g * 255.0).round().clamp(0, 255) / 255);
    final b = linearize((this.b * 255.0).round().clamp(0, 255) / 255);
    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }

  /// Returns black or white — whichever has better contrast against this color.
  /// Useful for choosing text color on a colored background.
  Color get contrastColor => isLight ? Colors.black : Colors.white;

  // ─── HSL Manipulation ────────────────────────────────────────────────────────

  /// Lightens this color by [amount] (0..1) in HSL space.
  ///
  /// ```dart
  /// Colors.blue.lighten(0.2)
  /// ```
  Color lighten(double amount) {
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness((hsl.lightness + amount).clamp(0.0, 1.0))
        .toColor();
  }

  /// Darkens this color by [amount] (0..1) in HSL space.
  Color darken(double amount) {
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }

  /// Returns a copy of this color with the given HSL [hue] (0..360).
  Color withHue(double hue) =>
      HSLColor.fromColor(this).withHue(hue.clamp(0.0, 360.0)).toColor();

  /// Returns a copy of this color with the given HSL [saturation] (0..1).
  Color withSaturation(double saturation) => HSLColor.fromColor(this)
      .withSaturation(saturation.clamp(0.0, 1.0))
      .toColor();

  /// Returns a copy of this color with the given HSL [lightness] (0..1).
  Color withLightness(double lightness) => HSLColor.fromColor(this)
      .withLightness(lightness.clamp(0.0, 1.0))
      .toColor();

  // ─── Color Mixing ────────────────────────────────────────────────────────────

  /// Linearly interpolates between this color and [other] by factor [t] (0..1).
  ///
  /// ```dart
  /// Colors.red.mix(Colors.blue, 0.5) // purple-ish
  /// ```
  Color mix(Color other, double t) => Color.lerp(this, other, t)!;

  /// Returns the complementary color (180° hue rotation).
  Color get complementary {
    final hsl = HSLColor.fromColor(this);
    return hsl.withHue((hsl.hue + 180) % 360).toColor();
  }

  /// Returns a desaturated (grayscale) version of this color.
  Color get grayscale {
    final gray = (luminance * 255).round();
    final alphaInt = (a * 255.0).round().clamp(0, 255);
    return Color.fromARGB(alphaInt, gray, gray, gray);
  }

  // ─── Palettes ────────────────────────────────────────────────────────────────

  /// Returns [count] analogous colors spaced [angle] degrees apart on the
  /// color wheel, centered on this color.
  ///
  /// ```dart
  /// Colors.blue.analogous() // 3 colors around blue
  /// ```
  List<Color> analogous({int count = 3, double angle = 30}) {
    final hsl = HSLColor.fromColor(this);
    final half = (count ~/ 2);
    return List.generate(
      count,
      (i) => hsl.withHue((hsl.hue + angle * (i - half)) % 360).toColor(),
    );
  }

  /// Returns the three colors of a triadic color scheme.
  List<Color> get triadic {
    final hsl = HSLColor.fromColor(this);
    return [
      this,
      hsl.withHue((hsl.hue + 120) % 360).toColor(),
      hsl.withHue((hsl.hue + 240) % 360).toColor(),
    ];
  }

  /// Returns the four colors of a tetradic (square) color scheme.
  List<Color> get tetradic {
    final hsl = HSLColor.fromColor(this);
    return [
      this,
      hsl.withHue((hsl.hue + 90) % 360).toColor(),
      hsl.withHue((hsl.hue + 180) % 360).toColor(),
      hsl.withHue((hsl.hue + 270) % 360).toColor(),
    ];
  }

  // ─── Conversion ──────────────────────────────────────────────────────────────

  /// Returns the hex string representation of this color.
  ///
  /// ```dart
  /// Colors.red.toHex() // '#FF0000'
  /// Colors.red.toHex(includeAlpha: true) // '#FFFF0000'
  /// ```
  String toHex({bool includeAlpha = false, bool upperCase = true}) {
    final rInt = (this.r * 255.0).round().clamp(0, 255);
    final gInt = (this.g * 255.0).round().clamp(0, 255);
    final bInt = (this.b * 255.0).round().clamp(0, 255);
    final aInt = (this.a * 255.0).round().clamp(0, 255);
    final r = rInt.toRadixString(16).padLeft(2, '0');
    final g = gInt.toRadixString(16).padLeft(2, '0');
    final b = bInt.toRadixString(16).padLeft(2, '0');
    final a = aInt.toRadixString(16).padLeft(2, '0');
    final hex = includeAlpha ? '#$a$r$g$b' : '#$r$g$b';
    return upperCase ? hex.toUpperCase() : hex.toLowerCase();
  }

  /// Generates a [MaterialColor] swatch from this color.
  ///
  /// Useful for creating a full theme from a single brand color.
  MaterialColor toMaterialColor() {
    final swatch = <int, Color>{
      50: lighten(0.40),
      100: lighten(0.32),
      200: lighten(0.24),
      300: lighten(0.16),
      400: lighten(0.08),
      500: this,
      600: darken(0.08),
      700: darken(0.16),
      800: darken(0.24),
      900: darken(0.32),
    };
    return MaterialColor(toARGB32(), swatch);
  }

  /// Returns the ARGB integer value of this color.
  int toArgb() => toARGB32();
}
