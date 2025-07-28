import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/pages/post_list_page.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '猫スナップ',
              style: GoogleFonts.sawarabiMincho(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: colorScheme.onPrimary,
              ),
            ),
            ElevatedButton.icon(
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
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
