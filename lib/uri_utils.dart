/// Extensions on [Uri] for real-world utility operations.
extension UriUtils on Uri {
  // ─── Path ────────────────────────────────────────────────────────────────────

  /// Appends a [segment] to the URI path.
  ///
  /// ```dart
  /// Uri.parse('https://api.example.com/v1').appendPath('users')
  /// // https://api.example.com/v1/users
  /// ```
  Uri appendPath(String segment) {
    final base = path.endsWith('/') ? path : '$path/';
    final seg = segment.startsWith('/') ? segment.substring(1) : segment;
    return replace(path: '$base$seg');
  }

  // ─── Query Parameters ────────────────────────────────────────────────────────

  /// Returns a new [Uri] with [key]=[value] added (or replaced) in the query.
  ///
  /// ```dart
  /// Uri.parse('https://example.com?page=1').withQueryParam('q', 'dart')
  /// // https://example.com?page=1&q=dart
  /// ```
  Uri withQueryParam(String key, String value) {
    final params = Map<String, String>.from(queryParameters);
    params[key] = value;
    return replace(queryParameters: params);
  }

  /// Returns a new [Uri] with all [params] merged into the query string.
  ///
  /// ```dart
  /// uri.withQueryParams({'page': '2', 'limit': '20'})
  /// ```
  Uri withQueryParams(Map<String, String> params) {
    final merged = Map<String, String>.from(queryParameters)..addAll(params);
    return replace(queryParameters: merged);
  }

  /// Returns a new [Uri] with [key] removed from the query string.
  ///
  /// ```dart
  /// Uri.parse('https://example.com?page=1&q=dart').removeQueryParam('q')
  /// // https://example.com?page=1
  /// ```
  Uri removeQueryParam(String key) {
    if (!queryParametersAll.containsKey(key)) return this;
    final params = Map<String, List<String>>.from(queryParametersAll)
      ..remove(key);
    if (params.isNotEmpty) return replace(queryParameters: params);
    // replace(query: null) keeps the original query; an empty string leaves '?'.
    return Uri(
      scheme: scheme,
      userInfo: userInfo,
      host: hasAuthority ? host : null,
      port: hasPort ? port : null,
      path: path,
      fragment: hasFragment ? fragment : null,
    );
  }

  // ─── Predicates ──────────────────────────────────────────────────────────────

  /// Returns `true` if this URI uses `https`.
  bool get isSecure => scheme == 'https';

  /// Returns `true` if this URI has at least one query parameter.
  bool get hasQueryParams => queryParameters.isNotEmpty;

  /// Returns `true` if this URI is an absolute URL (has scheme + host).
  bool get isAbsolute => hasScheme && host.isNotEmpty;
}
