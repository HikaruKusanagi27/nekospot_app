import 'package:flutter/material.dart';
import 'package:nekospot_app/post_page.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.pink[50]!,
              Colors.pink[100]!,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Column(
                children: [
                  Text(
                    '😽猫スナップ😽',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink[200]!.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.pets, color: Colors.pink[400]),
                      label: Text('はじめる'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PostPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.pink[400],
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
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(120),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink[200]!.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 15,
                            offset: Offset(0, 5),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [Colors.pink[100]!, Colors.purple[100]!],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      padding: EdgeInsets.all(8), // Creates border effect
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
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
