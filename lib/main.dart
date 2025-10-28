import 'package:egymillers/providers/general_provider.dart';
import 'package:egymillers/providers/product_prices_provider.dart';
import 'package:egymillers/providers/questions_provider.dart';
import 'package:egymillers/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ProductsPricesProvider()),
      ChangeNotifierProvider(create: (_) => QuestionsProvider()),
      ChangeNotifierProvider(create: (_) => GeneralProvider()),
    ],
    child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(()=> Provider.of<GeneralProvider>(context, listen: false).fetchSupportMessage());
  }
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
          );
  }
}
