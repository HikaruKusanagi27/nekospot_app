import 'package:flutter/material.dart';
import 'package:test/title_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.pink.shade100,
          useMaterial3: true,
        ),
        home: const TitlePage(),
      ),
    ),
  );
}
