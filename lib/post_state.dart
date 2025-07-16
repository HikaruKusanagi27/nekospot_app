import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

part 'post_state.freezed.dart';

@freezed
class PostState with _$PostState {
  const factory PostState({
    @Default(false) bool isLoading,
    Uint8List? imageBitmap,
    @Default('') String errorMessage,
    String? selectedPrefecture,
    String? imageError,
  }) = _PostState;
}

final postViewModelProvider =
    StateNotifierProvider<PostViewModel, PostState>((ref) {
  return PostViewModel();
});

class PostViewModel extends StateNotifier<PostState> {
  PostViewModel() : super(const PostState());

  void resetImage() {
    state = state.copyWith(imageBitmap: null);
  }

  Future<void> selectImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      state = state.copyWith(imageBitmap: bytes);
    }
  }

  void setPrefecture(String? prefecture) {
    state = state.copyWith(selectedPrefecture: prefecture);
  }

  void setImageError(String? error) {
    state = state.copyWith(imageError: error);
  }

  // Future<void> saveToFirebase({
  //   required String title,
  //   required String? prefectureName,
  //   required XFile? image,
  // }) async {
  //   try {
  //     String? imageUrl;
  //     if (image != null) {
  //       final fileName =
  //           DateTime.now().millisecondsSinceEpoch.toString(); // 現在の日時一意なファイル名
  //       final storageRef = FirebaseStorage.instance
  //           .ref()
  //           .child('post_images')
  //           .child('$fileName.jpg');
  //       await storageRef.putFile(File(image.path));
  //       imageUrl = await storageRef.getDownloadURL();
  //     }

  //     await FirebaseFirestore.instance.collection('posts').add({
  //       'title': title,
  //       'prefectureName': prefectureName,
  //       'imageUrl': imageUrl,
  //       'createdAt': FieldValue.serverTimestamp(),
  //     });
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error saving to Firebase: $e');
  //     }
  //   }
  // }

// 作業途中
  Future<void> saveToFirebase({
    required String title,
    required String? prefectureName,
    required XFile? image,
  }) async {
    // 画像をスマホのギャラリーから取得
    //final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    // 画像を取得できた場合はFirebaseStorageにアップロードする
    if (image != null) {
      final imageFile = File(image.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      try {
        await storage.ref('sample.png').putFile(imageFile);
      } catch (e) {
        print(e);
      }
    }
    return;
  }
}
