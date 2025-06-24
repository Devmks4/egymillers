import 'package:egymillers/shared/styles/colors.dart';
import 'package:egymillers/widgets/contact_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperScreen extends StatelessWidget {
  const DeveloperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackGround,
      appBar: AppBar(
        backgroundColor:primaryColor,
        title: Text(
          'معلومات عن المبرمج',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/logoo.png'),
                  height: 200,
                ),
                SizedBox(
                  height: 16,),
                Text(
                  'تمت برمجة التطبيق بواسطة',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'م/ محمد كمال',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'وسائل الاتصال',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                ContactTile(
                  icon: Icon(Icons.call),
                  title: '01151973777',
                  onPress: (){
                    _launchLink('tel:01151973777');
                  },
                ),
                ContactTile(
                  icon: Icon(FontAwesomeIcons.whatsapp),
                  title: '01018360062',
                  onPress: (){
                    sendWhatsAppMessage();
                  },
                ),
                ContactTile(
                  icon: Icon(Icons.email_rounded),
                  title: 'devmks4@gmail.com',
                  onPress: (){
                    _launchLink('mailto:devmks4@gmail.com');
                  },
                ),
                ContactTile(
                  icon: Icon(Icons.facebook_rounded),
                  title: 'www.fb.com/engMKS',
                  onPress: (){
                    _launchLink('https://www.fb.com/engmks');
                  },
                ),
                ContactTile(
                    icon: Icon(FontAwesomeIcons.globe),
                    title: 'github.com/Devmks4',
                    onPress: (){
                      _launchLink('https://www.github.com/Devmks4');
                    },
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'برجاء الاتصال في حالة وجود أي استفسارات',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
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

void sendWhatsAppMessage() async {
  final url = Uri.parse("https://wa.me/201018360062?text= السلام عليكم");
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch WhatsApp';
  }
}