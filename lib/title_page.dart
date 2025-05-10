import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/post_list_page.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Column(
              children: [
                Text(
                  '猫スナップ',
                  style: GoogleFonts.cabin(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    color: colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.pets,
                      color: colorScheme.secondary,
                    ),
                    label: Text(
                      'はじめる',
                      style: TextStyle(
                        color: colorScheme.secondary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostListPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: colorScheme.secondary,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(120),
                    gradient: LinearGradient(
                      colors: [
                        colorScheme.primary.withAlpha(77),
                        colorScheme.tertiary.withAlpha(77)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(110),
                    child: Image.asset(
                      'images/cat-5098930_640.jpg',
                      height: 400,
                      width: 400,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
