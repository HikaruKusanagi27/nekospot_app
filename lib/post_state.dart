import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as image_lib;

enum PostStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class PostState {
  final PostStateStatus status;
  final Uint8List? imageBitmap;
  final String? errorMessage;

  const PostState({
    this.status = PostStateStatus.initial,
    this.imageBitmap,
    this.errorMessage,
  });

  factory PostState.initial() => const PostState();

  factory PostState.loading() => const PostState(
        status: PostStateStatus.loading,
      );

  factory PostState.loaded(Uint8List imageBitmap) => PostState(
        status: PostStateStatus.loaded,
        imageBitmap: imageBitmap,
      );

  factory PostState.error(String message) => PostState(
        status: PostStateStatus.error,
        errorMessage: message,
      );

  PostState copyWith({
    PostStateStatus? status,
    Uint8List? imageBitmap,
    String? errorMessage,
  }) {
    return PostState(
      status: status ?? this.status,
      imageBitmap: imageBitmap ?? this.imageBitmap,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ImageSelector {
  final ImagePicker _picker = ImagePicker();

  Future<PostState> selectImage() async {
    try {
      // 画像を選択する
      final XFile? imageFile =
          await _picker.pickImage(source: ImageSource.gallery);

      if (imageFile == null) {
        return PostState.error('画像が選択されませんでした');
      }

      // ファイルオブジェクトから画像データを取得する
      final imageBitmap = await imageFile.readAsBytes();
      if (imageBitmap.isEmpty) {
        return PostState.error('画像データを取得できませんでした');
      }

      // 画像データをデコードする
      final image = image_lib.decodeImage(imageBitmap);
      if (image == null) {
        return PostState.error('画像のデコードに失敗しました');
      }

      // 画像をエンコードして状態を更新する
      final encodedImage = image_lib.encodeBmp(image);
      return PostState.loaded(encodedImage);
    } catch (e) {
      return PostState.error('エラーが発生しました: $e');
    }
  }
}
