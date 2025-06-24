import 'package:egymillers/models/home_screen_cards.dart';
import 'package:egymillers/screens/about_developer_screen.dart';
import 'package:egymillers/screens/app_support_screen.dart';
import 'package:egymillers/screens/ask_experience_screen.dart';
import 'package:egymillers/screens/products_prices_screen.dart';
import 'package:egymillers/screens/person_screen.dart';
import 'package:egymillers/screens/plansifter_calculation_screen.dart';
import 'package:egymillers/screens/power_calculations_screen.dart';
import 'package:egymillers/screens/quality_control_screen.dart';
import 'package:egymillers/screens/rollermill_calculations_screen.dart';
import 'package:egymillers/screens/silos_capacity_screen.dart';
import 'package:egymillers/widgets/home_screen_card.dart';
import 'package:flutter/material.dart';
import 'package:egymillers/screens/water_add_screen.dart';
import 'package:egymillers/screens/information_bank_screen.dart';
import 'package:egymillers/screens/release_screen.dart';
import 'package:egymillers/screens/silk_screen.dart';

class HomeScreenGridView extends StatelessWidget {
  HomeScreenGridView({super.key});
  final List cards = [
    HomeCard(title: 'حسابات الترطيب',image: 'assets/images/dampeningSystem.png',rOUTE: WaterAddScreen()),
    HomeCard(title: 'حسابات الريليز',image: 'assets/images/breakRelease.jpeg',rOUTE: ReleaseScreen()),
    HomeCard(title: 'مربع بيرسون',image: 'assets/images/personSquare.png',rOUTE: PersonScreen()),
    HomeCard(title: 'سعة الصوامع',image: 'assets/images/siloCapacity.jpg',rOUTE: SilosCapacityScreen()),
    HomeCard(title: 'قدرات المعدات',image: 'assets/images/bucketElevator.jpg',rOUTE: PowerCalculationsScreen()),
    HomeCard(title: 'مقاسات الحرير',image: 'assets/images/silkMeasures.jpg',rOUTE: SilkScreen()),
    HomeCard(title: 'مسطح الطحن',image: 'assets/images/rollermill.jpg',rOUTE: RollermillCalculationsScreen()),
    HomeCard(title: 'مسطح النخل',image: 'assets/images/Plansifter.jpg',rOUTE: PlansifterCalculationScreen()),
    HomeCard(title: 'بنك المعلومات',image: 'assets/images/bankOfInformation.webp',rOUTE: InfoBankScreen()),
    HomeCard(title: 'إسأل خبير',image: 'assets/images/es2lKhabeer.webp',rOUTE: AskExperienceScreen()),
    HomeCard(title: 'قسم الجودة',image: 'assets/images/qa.webp',rOUTE: QualityControlScreen()),
    HomeCard(title: 'بورصة المنتجات',image: 'assets/images/productsPrices.jpg',rOUTE: ProductsPricesScreen()),
    HomeCard(title: 'المبرمج',image: 'assets/images/developer.webp',rOUTE: DeveloperScreen()),
    HomeCard(title: 'دعم التطبيق',image: 'assets/images/donating.webp',rOUTE: SupportDeveloperPage()),
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: cards.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two columns
        childAspectRatio: 0.88, // Adjust height-to-width ratio
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return HomeScreenCard(homeCard: cards[index]);
      },
    );
  }
}
