import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:extension_utils/color_utils.dart';

void main() {
  group('ColorUtils', () {
    // ─── New Methods ─────────────────────────────────────────────────────────

    group('contrastRatio', () {
      test('black vs white = 21', () {
        expect(
          const Color(0xFF000000).contrastRatio(const Color(0xFFFFFFFF)),
          closeTo(21.0, 0.1),
        );
      });
      test('same color = 1', () {
        expect(
          const Color(0xFF000000).contrastRatio(const Color(0xFF000000)),
          closeTo(1.0, 0.01),
        );
      });
    });

    group('isAccessibleOn', () {
      test('white on black is accessible', () {
        expect(
          const Color(0xFFFFFFFF).isAccessibleOn(const Color(0xFF000000)),
          isTrue,
        );
      });
      test('white on white is not accessible', () {
        expect(
          const Color(0xFFFFFFFF).isAccessibleOn(const Color(0xFFFFFFFF)),
          isFalse,
        );
      });
    });

    group('splitComplementary', () {
      test('returns 2 colors', () {
        expect(const Color(0xFF0000FF).splitComplementary.length, 2);
      });
    });

    group('withOpacityPercent', () {
      test('50% opacity', () {
        final color = const Color(0xFFFF0000).withOpacityPercent(50);
        expect(color.a, closeTo(0.5, 0.01));
      });
      test('100% opacity', () {
        final color = const Color(0xFFFF0000).withOpacityPercent(100);
        expect(color.a, closeTo(1.0, 0.01));
      });
      test('0% opacity', () {
        final color = const Color(0xFFFF0000).withOpacityPercent(0);
        expect(color.a, closeTo(0.0, 0.01));
      });
    });

    group('shade', () {
      test('shade darkens color', () {
        const original = Color(0xFF0000FF);
        final shaded = original.shade(50);
        // Shaded should be darker (lower luminance)
        expect(
            shaded.computeLuminance(), lessThan(original.computeLuminance()));
      });
      test('shade 0 returns same color', () {
        const color = Color(0xFF0000FF);
        expect(color.shade(0).toARGB32(), color.toARGB32());
      });
    });

    group('tint', () {
      test('tint lightens color', () {
        const original = Color(0xFF0000FF);
        final tinted = original.tint(50);
        expect(tinted.computeLuminance(),
            greaterThan(original.computeLuminance()));
      });
      test('tint 0 returns same color', () {
        const color = Color(0xFF0000FF);
        expect(color.tint(0).toARGB32(), color.toARGB32());
      });
    });
  });
}
