import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_info.freezed.dart';

@freezed
class PostInfo with _$PostInfo {
  const factory PostInfo({
    required String imagePath, // サムネイル画像のパス
    required String iconPath, // アイコン画像のパス
    required String title, // 動画タイトル
    required String subTitle, // サブタイトル
  }) = _PostInfo;
}
