import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_test/flutter_test.dart';

import '../constants.dart';

void injectCSS() {
  final shouldSkip = kIsWeb
      ? false
      : ![
          TargetPlatform.android,
          TargetPlatform.iOS,
          TargetPlatform.macOS,
        ].contains(defaultTargetPlatform);

  var url = !kIsWeb ? TEST_URL_ABOUT_BLANK : TEST_WEB_PLATFORM_URL_1;

  group('inject CSS', () {
    testWidgets('code', (WidgetTester tester) async {
      final Completer<InAppWebViewController> controllerCompleter =
          Completer<InAppWebViewController>();
      final Completer<void> pageLoaded = Completer<void>();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: InAppWebView(
            key: GlobalKey(),
            initialUrlRequest: URLRequest(url: url),
            onWebViewCreated: (controller) {
              controllerCompleter.complete(controller);
            },
            onLoadStop: (controller, url) {
              pageLoaded.complete();
            },
          ),
        ),
      );

      final InAppWebViewController controller =
          await controllerCompleter.future;
      await pageLoaded.future;

      await controller.injectCSSCode(source: """
      body {
        background-color: rgb(0, 0, 255);
      }
      """);

      String? backgroundColor = await controller.evaluateJavascript(source: """
      var element = document.body;
      var style = getComputedStyle(element);
      style.backgroundColor;
      """);
      expect(backgroundColor, 'rgb(0, 0, 255)');
    });

    testWidgets('file from url', (WidgetTester tester) async {
      final Completer<InAppWebViewController> controllerCompleter =
          Completer<InAppWebViewController>();
      final Completer<void> pageLoaded = Completer<void>();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: InAppWebView(
            key: GlobalKey(),
            initialUrlRequest: URLRequest(url: url),
            onWebViewCreated: (controller) {
              controllerCompleter.complete(controller);
            },
            onLoadStop: (controller, url) {
              pageLoaded.complete();
            },
          ),
        ),
      );

      final InAppWebViewController controller =
          await controllerCompleter.future;
      await pageLoaded.future;

      await controller.injectCSSFileFromUrl(
          urlFile: Uri.parse(
              'https://getbootstrap.com/docs/4.3/dist/css/bootstrap.min.css'),
          cssLinkHtmlTagAttributes: CSSLinkHtmlTagAttributes(id: 'bootstrap'));
      await Future.delayed(Duration(seconds: 2));
      expect(
          await controller.evaluateJavascript(
              source: "document.head.querySelector('#bootstrap') == null;"),
          false);
    });

    testWidgets('file from asset', (WidgetTester tester) async {
      final Completer<InAppWebViewController> controllerCompleter =
          Completer<InAppWebViewController>();
      final Completer<void> pageLoaded = Completer<void>();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: InAppWebView(
            key: GlobalKey(),
            initialUrlRequest: URLRequest(url: url),
            onWebViewCreated: (controller) {
              controllerCompleter.complete(controller);
            },
            onLoadStop: (controller, url) {
              pageLoaded.complete();
            },
          ),
        ),
      );

      final InAppWebViewController controller =
          await controllerCompleter.future;
      await pageLoaded.future;

      await controller.injectCSSFileFromAsset(
          assetFilePath: 'test_assets/css/blue-body.css');

      String? backgroundColor = await controller.evaluateJavascript(source: """
      var element = document.body;
      var style = getComputedStyle(element);
      style.backgroundColor;
      """);
      expect(backgroundColor, 'rgb(0, 0, 255)');
    });
  }, skip: shouldSkip);
}
