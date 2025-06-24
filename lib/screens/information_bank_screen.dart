import 'package:egymillers/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'no_internet_screen.dart';

class InfoBankScreen extends StatefulWidget {
  const InfoBankScreen({super.key});

  @override
  _InfoBankScreen createState() => _InfoBankScreen();
}

class _InfoBankScreen extends State<InfoBankScreen> {
  late final WebViewController _controller;
  late final Stream<ConnectivityResult> _connectivityStream;
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();
    _connectivityStream = Connectivity().onConnectivityChanged;
    _connectivityStream.listen((ConnectivityResult result) {
      _updateConnectionStatus(result);
    });
    _checkConnection();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(Colors.white)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url) => print('Page started: $url'),
              onPageFinished: (url) {},
              onWebResourceError: (error) {
                print('Error: ${error.description}');
              },
            ),
          )
          ..loadRequest(Uri.parse('https://millersinfobank.blogspot.com/'));
  }
  Future<void> _checkConnection() async {
    final result = await Connectivity().checkConnectivity();
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    setState(() {
      _isOffline = result == ConnectivityResult.none;
    });
  }
  @override
  build(BuildContext context) {
    return _isOffline
        ? NoInternetScreen()
        : Scaffold(
      backgroundColor: scaffoldBackGround,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'بنك المعلومات',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(child: WebViewWidget(controller: _controller)),
    );
  }
}
