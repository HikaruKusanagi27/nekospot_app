import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as image_lib;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'post_state.freezed.dart';

@freezed
class PostState with _$PostState {
  const factory PostState({
    @Default(false) bool isLoading,
    Uint8List? imageBitmap,
    @Default('') String errorMessage,
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
    state = state.copyWith(isLoading: true);

    try {
      // 画像を選択する
      final XFile? imageFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (imageFile == null) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: '画像が選択されませんでした',
        );
        return;
      }

      // ファイルオブジェクトから画像データを取得する
      final imageBitmap = await imageFile.readAsBytes();

      // 画像データをデコードする
      final image = image_lib.decodeImage(imageBitmap);
      if (image == null) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: '画像の処理に失敗しました',
        );
        return;
      }

      // 画像をエンコードして状態を更新する
      state = state.copyWith(
        isLoading: false,
        imageBitmap: image_lib.encodeBmp(image),
        errorMessage: '',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '画像の処理中にエラーが発生しました: $e',
      );
    }
  }
}
