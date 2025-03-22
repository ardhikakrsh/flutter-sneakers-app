import 'package:flutter/material.dart';
import 'package:ppb_test/view/pages/payment/delivery_progress_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SnapWebViewScreen extends StatefulWidget {
  final String url;

  const SnapWebViewScreen({super.key, required this.url});

  @override
  State<SnapWebViewScreen> createState() => _SnapWebViewScreenState();
}

class _SnapWebViewScreenState extends State<SnapWebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('Loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Finished loading: $url');
            _checkTransactionStatus(url);
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  void _checkTransactionStatus(String url) {
    if (url.contains("status=success") ||
        url.contains("transaction_status=settlement")) {
      // Redirect ke Delivery Progress
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DeliveryProgressPage(),
        ),
      );
    } else if (url.contains("status=pending") ||
        url.contains("transaction_status=pending")) {
      // Redirect ke Delivery Progress
      Navigator.pop(context);
    } else if (url.contains("status=failure") ||
        url.contains("transaction_status=deny") ||
        url.contains("transaction_status=cancel") ||
        url.contains("transaction_status=expire")) {
      // Redirect ke Order Summary
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Payment'),
          centerTitle: true,
        ),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
