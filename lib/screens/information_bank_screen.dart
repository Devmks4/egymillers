import 'package:egymillers/shared/styles/colors.dart';
import 'package:egymillers/widgets/app_button.dart';
import 'package:egymillers/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 14.0),
        child: FloatingActionButton(
          shape: CircleBorder(),
          onPressed:(){
            _launchLink('mailto:engmks7.egymillers@blogger.com?subject=عنوان المقال&body=نص المقال');
          },
          backgroundColor: Colors.deepPurple[600],
          child: Icon(
            Icons.add,
            size: 32,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'بنك المعلومات',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'لإضافة مقال جديد أضغط على الزر و أرسل المقال في الايميل و سيتم إضافته مباشرة للموقع '
                    ),
                  ),
                  /*FloatingActionButton(
                    shape: CircleBorder(),
                    onPressed:(){
                      _launchLink('mailto:engmks7.egymillers@blogger.com');
                    },
                    backgroundColor: primaryColor,
                    child: Icon(
                      Icons.add,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),*/
                ],
              ),
              Appspacer(),
              Expanded(
                child: WebViewWidget(
                    controller: _controller
                ),
              ),
            ],
          ),
      ),
    );
  }
}
void _launchLink(String uri) async {
  final url = Uri.parse(uri);
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}