import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A flag of a country, rounded by default.
///
/// First positional argument is iso code of the country - can be used string
/// or [Flags] helper.
class CircleFlag extends StatelessWidget {
  static final FlagCache cache = FlagCache();
  final BytesLoader loader;
  final double size;

  /// [Clip] option for widget [ClipPath].
  ///
  /// This option have no effect if [shape] == null.
  final Clip clipBehavior;

  /// Clip the flag by [ShapeBorder], default: [CircleBorder].
  ///
  /// If null, return square flag.
  final ShapeBorder? shape;

  CircleFlag(
    String isoCode, {
    super.key,
    this.size = 48,
    this.shape = const CircleBorder(eccentricity: 0),
    this.clipBehavior = Clip.antiAlias,
  }) : loader = _createLoader(isoCode);

  /// check if a flag has been preloaded if so, returns its byteloader
  static BytesLoader _createLoader(String isoCode) {
    debugPrint("creating loader for $isoCode");
    debugPrint("cache 1: ${cache._loaders.keys}");
    debugPrint("cache 2: ${cache._loaders.values}");
    debugPrint("cache 3: ${cache._loaders.length}");
    // if (cache._loaders.containsKey(isoCode)) {
    //   debugPrint("cache hit for $isoCode");
    // }
    final cacheEntry = cache._loaders[isoCode];
    if (cacheEntry != null) {
      return cacheEntry;
    }
    return _FlagAssetLoader(isoCode);
  }

  /// preload a list of flags in memory
  static Future<void> preload(Iterable<String> isoCodes) {
    return cache.preload(isoCodes);
  }

  @override
  Widget build(BuildContext context) {
    final SvgPicture svg = SvgPicture(loader, width: size, height: size);

    final Widget clipped =
        shape == null
            ? svg
            : ClipPath(
              clipper: ShapeBorderClipper(shape: shape!, textDirection: Directionality.maybeOf(context)),
              clipBehavior: clipBehavior,
              child: svg,
            );
    return ExcludeSemantics(child: clipped);
  }
}

/// create an SvgAssetLoader that points to circle flag svg file
/// it will resolve to the "?" flag if the normal asset is not found
class _FlagAssetLoader extends SvgAssetLoader {
  final String isoCode;

  _FlagAssetLoader(this.isoCode) : super(computeAssetName(isoCode));

  static String computeAssetName(String isoCode) {
    return 'packages/phone_number_view/assets/svg/${isoCode.toLowerCase()}.svg';
  }

  static Future<ByteData> loadAsset(String assetName, [BuildContext? context, AssetBundle? assetBundle]) {
    final AssetBundle bundle = _FlagAssetLoader._resolveBundle(assetBundle, context);
    return bundle
        .load(assetName)
        // if any error loading a flag try to show the "?" flag
        .catchError((e) => rootBundle.load(_FlagAssetLoader.computeAssetName('xx')));
  }

  static AssetBundle _resolveBundle(AssetBundle? assetBundle, BuildContext? context) {
    if (assetBundle != null) {
      return assetBundle;
    }
    if (context != null) {
      return DefaultAssetBundle.of(context);
    }
    return rootBundle;
  }

  @override
  Future<ByteData?> prepareMessage(BuildContext? context) {
    final AssetBundle bundle = _resolveBundle(assetBundle, context);
    return bundle
        .load(computeAssetName(isoCode))
        // load "?" on error
        .catchError((e) => bundle.load(computeAssetName('xx')));
  }

  @override
  String provideSvg(ByteData? message) => utf8.decode(message!.buffer.asUint8List(), allowMalformed: true);

  @override
  SvgCacheKey cacheKey(BuildContext? context) {
    return SvgCacheKey(keyData: isoCode, theme: theme, colorMapper: colorMapper);
  }
}

/// a flag loader cache that allows for preloading
/// svg bytes.
/// Currently only caches preloaded items
class FlagCache {
  final Map<String, SvgBytesLoader> _loaders = <String, SvgBytesLoader>{};

  /// preloads flag data into svg cache
  Future<void> preload(Iterable<String> isoCodes, [BuildContext? context, AssetBundle? assetBundle]) async {
    final List<Future<void>> tasks = <Future<void>>[];
    for (final String isoCode in isoCodes) {
      final Future<void> task = _createLoader(isoCode, context, assetBundle).then((SvgBytesLoader loader) => _addLoaderToCache(isoCode, loader));
      tasks.add(task);
    }
    await Future.wait(tasks);
  }

  Future<SvgBytesLoader> _createLoader(String isoCode, BuildContext? context, AssetBundle? assetBundle) async {
    final String assetName = _FlagAssetLoader.computeAssetName(isoCode);
    final ByteData byteData = await _FlagAssetLoader.loadAsset(assetName, context, assetBundle);
    final SvgBytesLoader loader = SvgBytesLoader(Uint8List.sublistView(byteData));
    // add it to svg cache
    if (context != null && context.mounted) {
      svg.cache.putIfAbsent(loader.cacheKey(context), () => loader.loadBytes(context));
    }
    return loader;
  }

  void _addLoaderToCache(String isoCode, SvgBytesLoader loader) {
    _loaders[isoCode] = loader;
  }
}
