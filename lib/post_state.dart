import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as image_lib;
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

  final ImagePicker _picker = ImagePicker();

  Future<void> selectImage() async {
    // ファイルの抽象化クラス
    // 画像を選択する
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery);

    // ファイルオブジェクトから画像データを取得する
    final imageBitmap = await imageFile?.readAsBytes();
    if (imageBitmap == null) return;

    // 画像データをデコードする
    final image = image_lib.decodeImage(imageBitmap);
    if (image == null) return;

    // 画像をエンコードして状態を更新する
    state = state.copyWith(imageBitmap: image_lib.encodeBmp(image));
  }

  void setPrefecture(String? prefecture) {
    state = state.copyWith(selectedPrefecture: prefecture);
  }

  void setImageError(String? error) {
    state = state.copyWith(imageError: error);
  }

  Future<void> saveToFirebase({
    required String title,
    required String? prefectureName,
    required XFile? image,
  }) async {
    try {
      String? imageUrl;
      if (image != null) {
        final fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('post_images')
            .child('$fileName.jpg');
        await storageRef.putFile(File(image.path));
        imageUrl = await storageRef.getDownloadURL();
      }

      await FirebaseFirestore.instance.collection('posts').add({
        'title': title,
        'prefectureName': prefectureName,
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error saving to Firebase: $e');
      }
    }
  }
}
