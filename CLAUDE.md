# CLAUDE.md
必ず日本語で回答してください。
あなたはソクラテスのように、ユーザーが指定する命題について、ユーザーに質問してください。

条件：
ユーザーから指示がない限り、質問は繰り返し続けてください

1回の質問につき、1つの質問内容のみを出力してください

批判的な度合い：[1-10の範囲で指定]

質問を作る際のポイント：

1. 問いかける姿勢を持つ
2. オープンな質問をする
3. 追及する
4. 相手を否定しない
5. 聴くことに集中する
6. メタ認知を促す
7. 答えを出すのではなく、疑問を残す

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Flutter application called "nekospot_app" - a mobile app for sharing cat spot information with image uploads to Firebase Storage and data management via Cloud Firestore. The app uses Riverpod for state management and follows a provider-based architecture.

## Development Commands

### Essential Flutter Commands
- `flutter run` - Run the app in development mode
- `flutter build apk` - Build Android APK
- `flutter build ios` - Build iOS app
- `flutter test` - Run unit tests
- `flutter analyze` - Analyze code for issues
- `flutter clean` - Clean build artifacts
- `flutter pub get` - Install dependencies

### Code Generation
- `dart run build_runner build` - Generate code (freezed, riverpod_generator, retrofit, json_serializable)
- `dart run build_runner build --delete-conflicting-outputs` - Force regenerate all generated files
- `dart run build_runner watch` - Watch and auto-generate code during development

## Architecture

### State Management
- Uses **flutter_riverpod** for state management
- Providers are defined in `lib/providers/`
- State classes use **freezed** for immutable data structures
- Auto-generated providers using **riverpod_generator**

### Data Layer
- **Firebase Core** integration with configuration in `firebase_options.dart`
- **Cloud Firestore** for data persistence
- **Firebase Storage** for image uploads
- Model classes in `lib/models/` using **freezed** for immutability
- **Retrofit** with **Dio** for API calls (if applicable)

### UI Structure
- Main entry point: `lib/main.dart` with custom pink/purple theme
- Key pages:
  - `post_list_page.dart` - Main listing page
  - `post_page.dart` - Individual post details
  - `title_page.dart` - Title/landing page
- Uses **Google Fonts** for typography
- **Image Picker** for camera/gallery image selection

### Key Dependencies
- **freezed** + **json_annotation** for immutable models with JSON serialization
- **flutter_riverpod** + **riverpod_annotation** for state management
- **retrofit** + **dio** for HTTP client
- **logger** + **pretty_dio_logger** for debugging
- **shared_preferences** for local storage
- **path_provider** for file system access

## Development Workflow

1. After modifying models, providers, or API definitions, run code generation
2. Firebase configuration is handled automatically via `firebase_options.dart`
3. Images are stored in `images/` directory and referenced in `pubspec.yaml`
4. Use `pedantic_mono` linting rules for code style consistency

## Firebase Setup

The app uses Firebase with:
- Cloud Firestore for data storage
- Firebase Storage for image uploads
- Configuration files: `GoogleService-Info.plist` (iOS), `google-services.json` (Android)
- Firebase options auto-generated in `firebase_options.dart`

## Testing

- Unit tests should go in `test/` directory
- Use `flutter test` to run tests
- No specific test configuration found - follows Flutter defaults