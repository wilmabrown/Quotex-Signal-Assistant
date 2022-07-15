import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotex/internal/services/service_locator.dart';
import 'package:quotex/internal/services/settings.dart';
import 'package:quotex/internal/utils/infrastructure.dart';
import 'package:quotex/presentation/global/loader/q_loader.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TradingScreenView extends StatefulWidget {
  const TradingScreenView({Key? key}) : super(key: key);

  @override
  State<TradingScreenView> createState() => _TradingScreenViewState();
}

class _TradingScreenViewState extends State<TradingScreenView> {
  /// Прогрузился WebView или нет.
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    if (Platform.isIOS) {
      WebView.platform = CupertinoWebView();
    } else if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }
  }

  Widget _buildContent(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        WebView(
          initialUrl: service<Settings>().webviewUrl,
          backgroundColor: backgroundColor,
          onProgress: (h) {
            if (h >= 100) setState(() => isLoaded = true);
          },
          navigationDelegate: (action) {
            return NavigationDecision.navigate;
          },
          javascriptMode: JavascriptMode.unrestricted,
        ),
        if (!isLoaded) const QLoader(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'Trading',
          style: TextStyle(fontSize: 19.w, color: whiteColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: _buildContent(context),
    );
  }
}
