
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:largo/main.dart';
import 'package:largo/screen/screen_main.dart';
import 'package:largo/screen/screen_mypage.dart';
import 'package:uni_links/uni_links.dart';
import 'package:firebase_core/firebase_core.dart';


class DynamicLink {
  Future<bool> setup() async {
    FirebaseApp app = await Firebase.initializeApp();
    print('Initialized default app $app');
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
    if (dynamicLinkData.link.queryParameters.containsKey('id')) {
      String link = dynamicLinkData.link.path.split('/').last;
      String id = dynamicLinkData.link.queryParameters['id']!;

      switch (link) {
        case 'test':
          Get.offAll(
                () => ScreenMain(),
          );
          break;
        case 'mypage':
          Get.offAll(
                () => ScreenMypage(),
          );
          break;


      }
    }
  }

  Future<String> getShortLink(String screenName, String id) async {
    final dynamicLinkParams = DynamicLinkParameters(
      uriPrefix: 'https://largo.page.link/main',
      link: Uri.parse('https://largo.page.link/main/$screenName'),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.largo',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.example.largo',
        minimumVersion: '0',
      ),
    );
    final dynamicLink =
    await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    return dynamicLink.shortUrl.toString();
  }
}