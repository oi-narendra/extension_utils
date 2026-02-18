/// A collection of pre-built, commonly used [RegExp] patterns.
///
/// Use these to avoid rewriting the same validation regexes across projects.
///
/// ```dart
/// RegExpPatterns.email.hasMatch('user@example.com') // true
/// RegExpPatterns.uuid.hasMatch('550e8400-e29b-41d4-a716-446655440000') // true
/// ```
abstract final class RegExpPatterns {
  RegExpPatterns._();

  // ─── Contact ─────────────────────────────────────────────────────────────────

  /// Matches a valid email address.
  static final RegExp email = RegExp(
    r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
  );

  /// Matches common phone number formats (E.164 and regional variants).
  static final RegExp phone = RegExp(r'^\+?[\d\s\-()\.\[\]]{7,15}$');

  // ─── Web ─────────────────────────────────────────────────────────────────────

  /// Matches an http or https URL.
  static final RegExp url = RegExp(
    r'^https?://[^\s/$.?#].[^\s]*$',
    caseSensitive: false,
  );

  // ─── Identity ────────────────────────────────────────────────────────────────

  /// Matches a UUID v4 (case-insensitive).
  static final RegExp uuid = RegExp(
    r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
    caseSensitive: false,
  );

  // ─── Finance ─────────────────────────────────────────────────────────────────

  /// Matches common credit card numbers (Visa, MasterCard, Amex, Discover).
  static final RegExp creditCard = RegExp(
    r'^(?:4[0-9]{12}(?:[0-9]{3})?' // Visa
    r'|5[1-5][0-9]{14}' // MasterCard
    r'|3[47][0-9]{13}' // Amex
    r'|6(?:011|5[0-9]{2})[0-9]{12})$', // Discover
  );

  // ─── Network ─────────────────────────────────────────────────────────────────

  /// Matches a valid IPv4 address.
  static final RegExp ipv4 = RegExp(
    r'^((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$',
  );

  /// Matches a valid IPv6 address (simplified).
  static final RegExp ipv6 = RegExp(
    r'^(([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}|::1|::)$',
  );

  // ─── Color ───────────────────────────────────────────────────────────────────

  /// Matches a hex color code (`#RGB` or `#RRGGBB`, with or without `#`).
  static final RegExp hexColor = RegExp(
    r'^#?([a-fA-F0-9]{6}|[a-fA-F0-9]{3})$',
  );

  // ─── Postal ──────────────────────────────────────────────────────────────────

  /// Matches a US ZIP code (5 digits or ZIP+4).
  static final RegExp postalCode = RegExp(r'^\d{5}(-\d{4})?$');

  // ─── Character Classes ───────────────────────────────────────────────────────

  /// Matches a string containing only digits (0–9).
  static final RegExp digits = RegExp(r'^\d+$');

  /// Matches a string containing only alphabetic characters.
  static final RegExp alpha = RegExp(r'^[a-zA-Z]+$');

  /// Matches a string containing only alphanumeric characters.
  static final RegExp alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');

  // ─── Password ────────────────────────────────────────────────────────────────

  /// Matches a strong password: ≥8 chars, uppercase, lowercase, digit, special.
  static final RegExp strongPassword = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$%^&*(),.?":{}|<>]).{8,}$',
  );

  // ─── Slug / Identifier ───────────────────────────────────────────────────────

  /// Matches a URL-friendly slug (lowercase letters, digits, hyphens).
  static final RegExp slug = RegExp(r'^[a-z0-9]+(?:-[a-z0-9]+)*$');

  /// Matches a semantic version string (e.g. `1.2.3` or `1.2.3-beta.1`).
  static final RegExp semver = RegExp(
    r'^\d+\.\d+\.\d+(?:-[a-zA-Z0-9.]+)?(?:\+[a-zA-Z0-9.]+)?$',
  );
}
