import 'package:egymillers/models/home_screen_cards.dart';
import 'package:flutter/material.dart';

class HomeScreenCard extends StatelessWidget {
  final HomeCard homeCard;

  const HomeScreenCard({super.key, required this.homeCard});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => homeCard.rOUTE!),
        );
      },
      child: Card(
        color: Colors.amber[15],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.asset(
                      homeCard.image!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
              child: Center(
                child: FittedBox(
                  child: Text(
                    homeCard.title!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontFamily: 'Almarai',
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
