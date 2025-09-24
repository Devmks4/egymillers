import 'package:egymillers/widgets/home_screen_gridview.dart';
import 'package:flutter/material.dart';
import 'package:egymillers/shared/styles/colors.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:egymillers/screens/about_developer_screen.dart';
import 'package:egymillers/screens/app_support_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../shared/styles/styles.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: scaffoldBackGround,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          iconSize: 30,
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Text(
          'تطبيق الطحان المصري',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
spacing: 12,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: primaryColor),
              ),
              child: Text('الرجاء الدعاء لوالدي و والدتي بالرحمة والمغفرة',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(child: HomeScreenGridView()),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.transparent,
          child: navDrawer(context)
      ),
    );
  }
}

Widget navDrawer(BuildContext context) => SafeArea(
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(topRight: Radius.circular(100.0),bottomRight: Radius.circular(100.0)),
      color: Colors.grey[300],
    ),
    padding: EdgeInsets.all(4),
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(96.0)),
              color: primaryColor,
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('assets/icons/icooon2.png'),
              ),
          ),
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              'تطبيق الطحان المصري',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
        // ListTile(
        //   leading: Icon(Icons.account_circle),
        //   title: Text('الملف الشخصي',style: listTextStyle(),),
        //   onTap: () {
        //     Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => ProfileScreen()),
        //   );
        //     },
        // ),
        /*ListTile(
          leading: Icon(Icons.settings),
          title: Text('الإعدادات',style: listTextStyle(),),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          },
        ),*/
        ListTile(
          leading: Icon(Icons.input),
          title: Text('مشاركة التطبيق',style: listTextStyle(),),
          onTap: () {
          Share.share('Check out this awesome app: https://play.google.com/store/apps/details?id=com.codevolt.egymillers');
          },
        ),
        ListTile(
          leading: Icon(Icons.monetization_on_outlined),
          title: Text('دعم التطبيق',style: listTextStyle(),),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SupportDeveloperPage()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.developer_mode_sharp),
          title: Text('المبرمج',style: listTextStyle(),),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DeveloperScreen()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.message),
          title: Text('إرسال رسالة',style: listTextStyle(),),
          onTap: () {_openBottomSheet(context);},
        ),
        ListTile(
          leading: Icon(Icons.star_rate),
          title: Text('تقييم التطبيق',style: listTextStyle(),),
          onTap: () {
            _launchLink('https://play.google.com/store/apps/details?id=com.codevolt.egymillers');
          },
        ),
        ListTile(
          leading: Icon(Icons.apps),
          title: Text('تطبيقاتنا الأخرى',style: listTextStyle(),),
          onTap: () {
            _launchLink('https://play.google.com/store/apps/developer?id=CodeVolt');
            },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app_rounded),
          title: Text('خروج من التطبيق',style: listTextStyle(),),
          onTap: () => {SystemNavigator.pop()},
        ),
      ],
    ),
  ),
);

void _launchLink(String uri) async {
  final url = Uri.parse(uri);
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

void sendWhatsAppMessage(String msg) async {
  final phone = '201018360062'; // in international format, e.g., 919876543210
  final message = Uri.encodeComponent(msg);
  final url = Uri.parse("https://wa.me/$phone?text=$message");
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch WhatsApp';
  }
}

void _openBottomSheet(BuildContext context) {
  TextEditingController controller = TextEditingController();
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'أكتب رسالتك',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                sendWhatsAppMessage(controller.text);// Add your logic here
                Navigator.pop(context); // close bottom sheet
              },
              child: Text('إرسال'),
            ),
          ],
        ),
      );
    },
  );
}
