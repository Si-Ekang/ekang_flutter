import 'dart:io';

import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:fimber/fimber.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const String PUBLISHER_ID = "pub-2874893382669803";
const String ADS_CUTOMER_ID = "152-832-7404";

// You can also test with your own ad unit IDs by registering your device as a
// test device. Check the logs for your device's ID value.
const String testDevice = '38400000-8cf0-11bd-b23e-10b96e40000d';
const int maxFailedLoadAttempts = 3;

class AdsWidget extends StatefulWidget {
  const AdsWidget({super.key});

  @override
  State<StatefulWidget> createState() => AdsWidgetState();
}

class AdsWidgetState extends State<AdsWidget> {
  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  static const interstitialButtonText = 'InterstitialAd';
  static const rewardedButtonText = 'RewardedAd';
  static const rewardedInterstitialButtonText = 'RewardedInterstitialAd';
  static const fluidButtonText = 'Fluid';
  static const inlineAdaptiveButtonText = 'Inline adaptive';
  static const anchoredAdaptiveButtonText = 'Anchored adaptive';
  static const nativeTemplateButtonText = 'Native template';
  static const webviewExampleButtonText = 'Register WebView';
  static const adInspectorButtonText = 'Ad Inspector';

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  RewardedInterstitialAd? _rewardedInterstitialAd;
  int _numRewardedInterstitialLoadAttempts = 0;

  @override
  void initState() {
    super.initState();
    MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(testDeviceIds: [testDevice]));
    _createInterstitialAd();
    _createRewardedAd();
    _createRewardedInterstitialAd();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/1033173712'
            : 'ca-app-pub-3940256099942544/4411468910',
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            Fimber.d('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            Fimber.e('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      Fimber.d('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          Fimber.d('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        Fimber.w('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        Fimber.e('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/5224354917'
            : 'ca-app-pub-3940256099942544/1712485313',
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            Fimber.d('$ad loaded.');
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            Fimber.e('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedAd();
            }
          },
        ));
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      Fimber.d('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          Fimber.d('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        Fimber.w('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        Fimber.e('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      Fimber.d('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedAd = null;
  }

  void _createRewardedInterstitialAd() {
    RewardedInterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/5354046379'
            : 'ca-app-pub-3940256099942544/6978759866',
        request: request,
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          onAdLoaded: (RewardedInterstitialAd ad) {
            Fimber.d('$ad loaded.');
            _rewardedInterstitialAd = ad;
            _numRewardedInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            Fimber.e('RewardedInterstitialAd failed to load: $error');
            _rewardedInterstitialAd = null;
            _numRewardedInterstitialLoadAttempts += 1;
            if (_numRewardedInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedInterstitialAd();
            }
          },
        ));
  }

  void _showRewardedInterstitialAd() {
    if (_rewardedInterstitialAd == null) {
      Fimber.d('Warning: attempt to show rewarded interstitial before loaded.');
      return;
    }
    _rewardedInterstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedInterstitialAd ad) =>
          Fimber.d('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
        Fimber.w('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedInterstitialAd();
      },
      onAdFailedToShowFullScreenContent:
          (RewardedInterstitialAd ad, AdError error) {
        Fimber.e('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedInterstitialAd();
      },
    );

    _rewardedInterstitialAd!.setImmersiveMode(true);
    _rewardedInterstitialAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      Fimber.d('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedInterstitialAd = null;
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    _rewardedInterstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('AdMob Plugin example app'),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: (String result) {
                  switch (result) {
                    case interstitialButtonText:
                      _showInterstitialAd();
                      break;
                    case rewardedButtonText:
                      _showRewardedAd();
                      break;
                    case rewardedInterstitialButtonText:
                      _showRewardedInterstitialAd();
                      break;
                    case fluidButtonText:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FluidExample()),
                      );
                      break;
                    case inlineAdaptiveButtonText:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InlineAdaptiveExample()),
                      );
                      break;
                    case anchoredAdaptiveButtonText:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AnchoredAdaptiveExample()),
                      );
                      break;
                    case nativeTemplateButtonText:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NativeTemplateExample()),
                      );
                      break;
                    case webviewExampleButtonText:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebViewExample()),
                      );
                      break;
                    case adInspectorButtonText:
                      MobileAds.instance.openAdInspector((error) => Fimber.d(
                          'Ad Inspector ${error == null ? 'opened.' : 'error: ${error.message ?? ''}'}'));
                      break;
                    default:
                      throw AssertionError('unexpected button: $result');
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: interstitialButtonText,
                    child: Text(interstitialButtonText),
                  ),
                  PopupMenuItem<String>(
                    value: rewardedButtonText,
                    child: Text(rewardedButtonText),
                  ),
                  PopupMenuItem<String>(
                    value: rewardedInterstitialButtonText,
                    child: Text(rewardedInterstitialButtonText),
                  ),
                  PopupMenuItem<String>(
                    value: fluidButtonText,
                    child: Text(fluidButtonText),
                  ),
                  PopupMenuItem<String>(
                    value: inlineAdaptiveButtonText,
                    child: Text(inlineAdaptiveButtonText),
                  ),
                  PopupMenuItem<String>(
                    value: anchoredAdaptiveButtonText,
                    child: Text(anchoredAdaptiveButtonText),
                  ),
                  PopupMenuItem<String>(
                    value: nativeTemplateButtonText,
                    child: Text(nativeTemplateButtonText),
                  ),
                  PopupMenuItem<String>(
                    value: webviewExampleButtonText,
                    child: Text(webviewExampleButtonText),
                  ),
                  PopupMenuItem<String>(
                    value: adInspectorButtonText,
                    child: Text(adInspectorButtonText),
                  ),
                ],
              ),
            ],
          ),
          body: SafeArea(child: ReusableInlineExample()),
        );
      }),
    );
  }

  Widget FluidExample() => Container(
        child: Text("Fluid Example"),
      );
  Widget InlineAdaptiveExample() => Container(
        child: Text("Inline Adaptive Example"),
      );
  Widget AnchoredAdaptiveExample() => Container(
        child: Text("Anchored Adaptive Example"),
      );
  Widget NativeTemplateExample() => Container(
        child: Text("Native Template Example"),
      );
  Widget WebViewExample() => Container(
        child: Text("WebView Example"),
      );
  Widget ReusableInlineExample() => Container(
        child: Text("Reusable Inline Example"),
      );
}
