import 'package:flutter/material.dart';
import 'package:test/title_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// テーマカラーを拡張するための定数
class AppColors {
  static const textAlt = Color(0xFF6A1B9A); // 紫色のテキスト用
  static const textEmphasized = Color(0xFFD81B60); // 強調テキスト用
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Colors.pink.shade100,
            surface: Colors.pink.shade100,
            onPrimary: Colors.black,
            secondary: Colors.pinkAccent,
            onSecondary: Colors.white,
            tertiary: Colors.purpleAccent,
            onTertiary: Colors.white,
            error: Colors.red,
            onError: Colors.white,
            onSurface: Colors.black,
          ),
          useMaterial3: true,
        ),
        home: const TitlePage(),
      ),
    ),
  );
}
