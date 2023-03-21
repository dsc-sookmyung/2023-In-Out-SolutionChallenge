
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:largo/main.dart';
import 'package:largo/screen/screen_main.dart';
import 'package:largo/screen/screen_mypage.dart';
import 'package:uni_links/uni_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:share_plus/share_plus.dart';

class DynamicLink {
  Future<bool> setup() async {
    FirebaseApp app = await Firebase.initializeApp();
    print('Initialized default app $app');

    // Share.share(
    //   await getShortLink(
    //      'main',
    //     'main'
    //    ),
    //  );

    bool isExistDynamicLink = await _getInitialDynamicLink();
    _addListener();

    logger.d('start');
    return isExistDynamicLink;
  }

  Future<bool> _getInitialDynamicLink() async {

    final String? deepLink = await getInitialLink();

    if (deepLink != null) {
      PendingDynamicLinkData? dynamicLinkData = await FirebaseDynamicLinks
          .instance
          .getDynamicLink(Uri.parse(deepLink));

      if (dynamicLinkData != null) {
        _redirectScreen(dynamicLinkData);

        return true;
      }
    }

    return false;
  }

  void _addListener() {
    FirebaseDynamicLinks.instance.onLink.listen((
        PendingDynamicLinkData dynamicLinkData,
        ) {
      _redirectScreen(dynamicLinkData);
    }).onError((error) {
      logger.e(error);
    });
  }

  void _redirectScreen(PendingDynamicLinkData dynamicLinkData) {
    if (dynamicLinkData.link.queryParameters.containsKey('route')) {
      String link = dynamicLinkData.link.path.split('/').last;
      String route = dynamicLinkData.link.queryParameters['route']!;

      switch (link) {
        case 'main':
          Get.offAll(
                () => ScreenMain(),
            arguments: {
              "route": route,
            }
          );
          break;
      }
    }
  }

  Future<String> getShortLink(String screenName, String id) async {
    final dynamicLinkParams = DynamicLinkParameters(
      uriPrefix: 'https://largo.page.link',
      link: Uri.parse('https://largo.page.link/$screenName?route=$id'),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.largo',
        minimumVersion: 20,
      ),
    );
    final dynamicLink =
    await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    return dynamicLink.shortUrl.toString();
  }
}