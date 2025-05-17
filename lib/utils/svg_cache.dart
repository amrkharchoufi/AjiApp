// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A utility class to cache SVG assets and prevent repeated loading
/// which improves performance by reducing rendering operations
class SvgCache {
  static final Map<String, SvgPicture> _cache = {};

  /// Get a cached SVG asset, or load and cache it if not already cached
  static SvgPicture getAsset(
    String assetName, {
    Color? color,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Alignment alignment = Alignment.center,
  }) {
    final key = '$assetName-$color-$width-$height-$fit-$alignment';

    if (!_cache.containsKey(key)) {
      _cache[key] = SvgPicture.asset(
        assetName,
        color: color,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
      );
    }

    return _cache[key]!;
  }

  /// Get a cached network SVG, or load and cache it if not already cached
  static SvgPicture getNetwork(
    String url, {
    Color? color,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Alignment alignment = Alignment.center,
    Widget Function(BuildContext)? placeholderBuilder,
  }) {
    final key = '$url-$color-$width-$height-$fit-$alignment';

    if (!_cache.containsKey(key)) {
      _cache[key] = SvgPicture.network(
        url,
        color: color,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        placeholderBuilder: placeholderBuilder,
      );
    }

    return _cache[key]!;
  }

  /// Clear the SVG cache to free up memory if needed
  static void clearCache() {
    _cache.clear();
  }
}
