import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A utility class for optimizing image loading and caching
class ImageCacheManager {
  /// Maximum width for images to prevent loading oversized images
  static const int maxWidth = 1080;

  /// Maximum height for images to prevent loading oversized images
  static const int maxHeight = 1920;

  /// Common asset images that should be pre-cached for faster loading
  static const List<String> _commonAssetImages = [
    'assets/images/background.png',
    'assets/images/secondbackground.png',
    'assets/images/follow_featured.jpg',
    'assets/images/sim.jpg',
    'assets/images/matchday.jpg',
    'assets/images/upcomingpic1.jpg',
    'assets/images/upcomingpic2.jpg',
    'assets/images/city1.png',
    'assets/images/city2.png',
    'assets/images/mosque.png',
  ];

  /// Pre-cache commonly used images to improve app startup performance
  /// Should be called after app has a valid BuildContext, like in your home page's initState
  static Future<void> precacheCommonImages(BuildContext context) async {
    for (final String asset in _commonAssetImages) {
      await precacheAssetImage(context, asset);
    }
  }

  /// Pre-cache a specific asset image
  static Future<void> precacheAssetImage(
      BuildContext context, String assetPath) async {
    try {
      final AssetImage assetImage = AssetImage(assetPath);
      await precacheImage(assetImage, context);
    } catch (e) {
      debugPrint('Failed to precache $assetPath: $e');
    }
  }

  /// Load an optimized resized asset image
  static Image getOptimizedAssetImage(
    String assetPath, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      cacheWidth: width != null ? width.toInt() : null,
      cacheHeight: height != null ? height.toInt() : null,
      filterQuality: FilterQuality.medium,
    );
  }

  /// Get an optimized network image with caching and proper error handling
  static Widget getOptimizedNetworkImage(
    String url, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    // Determine cache dimensions based on provided or default dimensions
    final int? cacheWidth = width != null
        ? (width * 2 > maxWidth ? maxWidth : width * 2).toInt()
        : null;
    final int? cacheHeight = height != null
        ? (height * 2 > maxHeight ? maxHeight : height * 2).toInt()
        : null;

    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      memCacheWidth: cacheWidth,
      memCacheHeight: cacheHeight,
      placeholder: (context, url) =>
          placeholder ??
          Container(
            color: Colors.grey[200],
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Container(
            color: Colors.grey[300],
            child: const Icon(
              Icons.error,
              color: Colors.red,
            ),
          ),
      filterQuality: FilterQuality.medium,
    );
  }

  /// Clear memory cache to free up memory if needed
  static void clearMemoryCache() {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  }
}
