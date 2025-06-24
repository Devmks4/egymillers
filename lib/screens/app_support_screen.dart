import 'package:egymillers/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';


class SupportDeveloperPage extends StatelessWidget {
  const SupportDeveloperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackGround,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'دعم التطبيق',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'إذا أعجبك التطبيق و استفدت منه يمكنك دعم المبرمج من هنا للاستمرار في تقديم خدماتنا',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                _launchLink('tel:01018360062');
              },
              child: const Text('Vodafone Cash'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: (){
                _launchLink('tel:01151973777');
              },
              child: const Text('Smart Wallet CIB'),
            ),

            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Share.share('Check out this awesome app: https://play.google.com/store/apps/details?id=com.codevolt.egymillers');
              },
              icon: const Icon(Icons.share),
              label: const Text('مشاركة التطبيق'),
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