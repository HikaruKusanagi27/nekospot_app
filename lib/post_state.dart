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

  PostState get state => _state;

  Future<void> _selectImage() async {
    // ファイルの抽象化クラス
    // 画像を選択する
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery);

    // ファイルオブジェクトから画像データを取得する
    final imageBitmap = await imageFile?.readAsBytes();
    assert(imageBitmap != null);
    if (imageBitmap == null) return;

    // 画像データをデコードする
    final image = image_lib.decodeImage(imageBitmap);
    assert(image != null);
    if (image == null) return;

    // // 画像データとメタデータを内包したクラス
    // final image_lib.Image resizedImage;
    // if (image.width > image.height) {
    //   // 横長の画像なら横幅を500にリサイズする
    //   resizedImage = image_lib.copyResize(image, width: 500);
    // } else {
    //   // 縦長の画像なら縦幅を500にリサイズする
    //   resizedImage = image_lib.copyResize(image, height: 500);
    // }

    // 画像をエンコードして状態を更新する
    setState(() {
      _imageBitmap = image_lib.encodeBmp(image);
    });
  }
}
