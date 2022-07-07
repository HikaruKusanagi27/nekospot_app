import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_info.freezed.dart';

@freezed
class PostInfo with _$PostInfo {
  const factory PostInfo({
    required String imagePath, // サムネイル画像のパス
    required String title, // タイトル
    required String prefectureName, // 県名
  }) = _PostInfo;
}
