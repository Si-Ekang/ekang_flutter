import 'dart:io';

import 'package:ekang_flutter/core/utils/log.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const String PUBLISHER_ID = "pub-2874893382669803";
const String ADS_CUTOMER_ID = "152-832-7404";

// You can also test with your own ad unit IDs by registering your device as a
// test device. Check the logs for your device's ID value.
const String testDeviceSamsungGalaxyNote8 = 'E18917C9BA2DA30B0A87BDEE1437C5D4';
const String testDevice1 = '38400000-8cf0-11bd-b23e-10b96e40000d';
const String testDevice2 = '38400000-8cf0-11bd-b23e-10b96e40000e';
const String testDevice3 = '38400000-8cf0-11bd-b23e-10b96e40000f';

const int maxFailedLoadAttempts = 3;

class SiEkangAdsManager {
  final String _testAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/9257395921'
      : 'ca-app-pub-3940256099942544/5575463023';

  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  bool _isShowingAd = false;

  /// Maximum duration allowed between loading and showing the ad.
  final Duration maxCacheDuration = Duration(hours: 4);

  /// Keep track of load time so we don't show an expired ad.
  DateTime? _appOpenLoadTime;

  // Single instantiation only
  static final SiEkangAdsManager _singleton = SiEkangAdsManager._();

  // Returns value of the instantiation
  factory SiEkangAdsManager() => _singleton;

  // Private constructor
  SiEkangAdsManager._();

  void updateRequestConfiguration(List<String>? testDevices) {
    MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(testDeviceIds: testDevices),
    );
  }

  /// Load an InterstitialAd.
  void loadAd() {
    if (null != _interstitialAd) {
      _interstitialAd!.dispose();
      _interstitialAd = null;
    }

    InterstitialAd.load(
      adUnitId: _adUnitId,
      request: request,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          Log.d("loadAd", '$ad loaded');
          _appOpenLoadTime = DateTime.now();

          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          _interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (error) {
          Log.e("loadAd", 'AppOpenAd failed to load: $error');
          // Handle the error.
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
            loadAd();
          }
        },
      ),
    );
  }

  /// Whether an ad is available to be shown.
  bool get isAdAvailable {
    return _interstitialAd != null;
  }

  void showAdIfAvailable() {
    if (_interstitialAd == null) {
      Log.d(
        "showAdIfAvailable",
        'Warning: attempt to show interstitial before loaded.',
      );
      return;
    }

    if (!isAdAvailable) {
      Log.w(
        "showAdIfAvailable",
        'showAdIfAvailable() | Tried to show ad before available.',
      );
      loadAd();
      return;
    }

    if (_isShowingAd) {
      Log.d(
        "showAdIfAvailable",
        'showAdIfAvailable() | Tried to show ad while already showing an ad.',
      );
      return;
    }

    if (DateTime.now().subtract(maxCacheDuration).isAfter(_appOpenLoadTime!)) {
      Log.d(
        "showAdIfAvailable",
        'Maximum cache duration exceeded. Loading another ad.',
      );
      _interstitialAd!.dispose();
      _interstitialAd = null;
      loadAd();
      return;
    }

    // Set the fullScreenContentCallback and show the ad.
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        Log.d(
          "showAdIfAvailable",
          'fullScreenContentCallback | $ad onAdShowedFullScreenContent',
        );
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        Log.e(
          "showAdIfAvailable",
          '$ad onAdFailedToShowFullScreenContent: $error',
        );
        _isShowingAd = false;
        ad.dispose();
        _interstitialAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        Log.w("showAdIfAvailable", '$ad onAdDismissedFullScreenContent');
        _isShowingAd = false;
        ad.dispose();
        _interstitialAd = null;
        loadAd();
      },
    );
    _interstitialAd!.show();
  }
}
