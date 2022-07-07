// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PostInfo {
  String get imagePath => throw _privateConstructorUsedError; // サムネイル画像のパス
  String get title => throw _privateConstructorUsedError; // タイトル
  String get prefectureName => throw _privateConstructorUsedError;

  /// Create a copy of PostInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostInfoCopyWith<PostInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostInfoCopyWith<$Res> {
  factory $PostInfoCopyWith(PostInfo value, $Res Function(PostInfo) then) =
      _$PostInfoCopyWithImpl<$Res, PostInfo>;
  @useResult
  $Res call({String imagePath, String title, String prefectureName});
}

/// @nodoc
class _$PostInfoCopyWithImpl<$Res, $Val extends PostInfo>
    implements $PostInfoCopyWith<$Res> {
  _$PostInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imagePath = null,
    Object? title = null,
    Object? prefectureName = null,
  }) {
    return _then(_value.copyWith(
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      prefectureName: null == prefectureName
          ? _value.prefectureName
          : prefectureName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostInfoImplCopyWith<$Res>
    implements $PostInfoCopyWith<$Res> {
  factory _$$PostInfoImplCopyWith(
          _$PostInfoImpl value, $Res Function(_$PostInfoImpl) then) =
      __$$PostInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String imagePath, String title, String prefectureName});
}

/// @nodoc
class __$$PostInfoImplCopyWithImpl<$Res>
    extends _$PostInfoCopyWithImpl<$Res, _$PostInfoImpl>
    implements _$$PostInfoImplCopyWith<$Res> {
  __$$PostInfoImplCopyWithImpl(
      _$PostInfoImpl _value, $Res Function(_$PostInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imagePath = null,
    Object? title = null,
    Object? prefectureName = null,
  }) {
    return _then(_$PostInfoImpl(
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      prefectureName: null == prefectureName
          ? _value.prefectureName
          : prefectureName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PostInfoImpl implements _PostInfo {
  const _$PostInfoImpl(
      {required this.imagePath,
      required this.title,
      required this.prefectureName});

  @override
  final String imagePath;
// サムネイル画像のパス
  @override
  final String title;
// タイトル
  @override
  final String prefectureName;

  @override
  String toString() {
    return 'PostInfo(imagePath: $imagePath, title: $title, prefectureName: $prefectureName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostInfoImpl &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.prefectureName, prefectureName) ||
                other.prefectureName == prefectureName));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, imagePath, title, prefectureName);

  /// Create a copy of PostInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostInfoImplCopyWith<_$PostInfoImpl> get copyWith =>
      __$$PostInfoImplCopyWithImpl<_$PostInfoImpl>(this, _$identity);
}

abstract class _PostInfo implements PostInfo {
  const factory _PostInfo(
      {required final String imagePath,
      required final String title,
      required final String prefectureName}) = _$PostInfoImpl;

  @override
  String get imagePath; // サムネイル画像のパス
  @override
  String get title; // タイトル
  @override
  String get prefectureName;

  /// Create a copy of PostInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostInfoImplCopyWith<_$PostInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
