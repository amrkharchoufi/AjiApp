import 'package:ajiapp/services/followyourteam_service/model/fixture_model.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class FootballStandingsWidget extends StatefulWidget {
  final int season;
  final int leagueid;
  final FixtureSimple fixture;
  final String token;
  const FootballStandingsWidget(
      {super.key,
      required this.season,
      required this.leagueid,
      required this.token,
      required this.fixture});

  @override
  State<FootballStandingsWidget> createState() =>
      _FootballStandingsWidgetState();
}

class _FootballStandingsWidgetState extends State<FootballStandingsWidget> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    // Initialize platform-specific parameters
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    // Create the controller with platform parameters
    controller = WebViewController.fromPlatformCreationParams(params);

    controller.setOverScrollMode(WebViewOverScrollMode.ifContentScrolls);
    controller.setBackgroundColor(const Color(0x00FFFFFF));
    // Configure the controller
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Optional: Show loading progress
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {
            print('Error loading widget: ${error.description}');
          },
        ),
      )
      ..loadHtmlString(_buildHtmlContent());

    // Platform-specific settings
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(
          true); // Optional, for development only
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
  }

  String _buildHtmlContent() {
    return '''
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
          body { margin: 0; padding: 0; background-color: #ffffff; }
          /* Make sure the widget is responsive */
          #wg-api-football-standings { width: 100%; height: 100%; }
        </style>
      </head>
      <body>
        <div id="wg-api-football-standings"
          data-host="v3.football.api-sports.io"
          data-key="${widget.token}"
          data-league="${widget.leagueid}"
          data-team=""
          data-season="${widget.season}"
          data-theme=""
          data-show-errors="false"
          data-show-logos="true"
          class="wg_loader">
        </div>
        <script
          type="module"
          src="https://widgets.api-sports.io/2.0.3/widgets.js">
        </script>
      </body>
      </html>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 820, child: WebViewWidget(controller: controller));
  }
}
