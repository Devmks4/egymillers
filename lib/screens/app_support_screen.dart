import 'package:egymillers/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';


class SupportDeveloperPage extends StatefulWidget {
  const SupportDeveloperPage({super.key});

  @override
  State<SupportDeveloperPage> createState() => _SupportDeveloperPageState();
}

class _SupportDeveloperPageState extends State<SupportDeveloperPage> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override

  void initState() {
    super.initState();
    // مدة الحركة
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // الحركة من أسفل لأعلى
    _animation = Tween<Offset>(
      begin: const Offset(0, 1), // أسفل الشاشة
      end: const Offset(0, -1), // أعلى الشاشة
    ).animate(_controller);
  }

  @override

  void dispose() {
    _controller.dispose();
    super.dispose();
  }
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
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                Share.share('Check out this awesome app: https://play.google.com/store/apps/details?id=com.codevolt.egymillers');
              },
              icon: const Icon(Icons.share),
              label: const Text('مشاركة التطبيق'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                 width: double.infinity,
                 decoration: BoxDecoration(
                   color: Colors.green[200],
                   borderRadius: BorderRadius.circular(10),
                 ),
                child: ClipRect(
                  child: SlideTransition(
                    position: _animation,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 7,
                        children: const [
                          Text(
                            "شكر خاص لكل من شارك بعلمه",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              height: 1.5, // مسافة بين السطور
                            ),
                            textAlign: TextAlign.center, // محاذاة النص
                          ),
                          Text(
                            "م / أسامه عباس ",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              height: 1.5, // مسافة بين السطور
                            ),
                            textAlign: TextAlign.center, // محاذاة النص
                          ),
                          Text(
                            "م / حسين محمد",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              height: 1.5, // مسافة بين السطور
                            ),
                            textAlign: TextAlign.center, // محاذاة النص
                          ),
                          Text(
                            "م / عبد الرحمن أبو الجود ",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              height: 1.5, // مسافة بين السطور
                            ),
                            textAlign: TextAlign.center, // محاذاة النص
                          ),
                          Text(
                            "م / عمر خليفة ",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              height: 1.5, // مسافة بين السطور
                            ),
                            textAlign: TextAlign.center, // محاذاة النص
                          ),
                          Text(
                            "م / محمد حلمي ",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              height: 1.5, // مسافة بين السطور
                            ),
                            textAlign: TextAlign.center, // محاذاة النص
                          ),
                          Text(
                            "م / إيهاب صلاح",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              height: 1.5, // مسافة بين السطور
                            ),
                            textAlign: TextAlign.center, // محاذاة النص
                          ),
                          Text(
                            "و نأسف إن خانتنا الذاكرة بذكر أحد الزملاء",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              height: 1.5, // مسافة بين السطور
                            ),
                            textAlign: TextAlign.center, // محاذاة النص
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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