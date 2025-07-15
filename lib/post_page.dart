import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'post_state.dart';
import 'package:flutter/services.dart';

// 都道府県リストを追加
final List<String> _prefectures = [
  '北海道',
  '青森県',
  '岩手県',
  '宮城県',
  '秋田県',
  '山形県',
  '福島県',
  '茨城県',
  '栃木県',
  '群馬県',
  '埼玉県',
  '千葉県',
  '東京都',
  '神奈川県',
  '新潟県',
  '富山県',
  '石川県',
  '福井県',
  '山梨県',
  '長野県',
  '岐阜県',
  '静岡県',
  '愛知県',
  '三重県',
  '滋賀県',
  '京都府',
  '大阪府',
  '兵庫県',
  '奈良県',
  '和歌山県',
  '鳥取県',
  '島根県',
  '岡山県',
  '広島県',
  '山口県',
  '徳島県',
  '香川県',
  '愛媛県',
  '高知県',
  '福岡県',
  '佐賀県',
  '長崎県',
  '熊本県',
  '大分県',
  '宮崎県',
  '鹿児島県',
  '沖縄県'
];

// 選択された都道府県を保持する変数
String? _selectedPrefecture;

XFile? _image;
final _formKey = GlobalKey<FormState>();
final picker = ImagePicker();
final _nameController = TextEditingController();

void resetPostPageState(WidgetRef ref) {
  _nameController.clear();
  _selectedPrefecture = null;
  _image = null;
  ref.read(postViewModelProvider.notifier).resetImage();
}

class PostPage extends ConsumerWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const textColor = Colors.black;
    final colorScheme = Theme.of(context).colorScheme;
    final postState = ref.watch(postViewModelProvider);
    final imageBitmap = postState.imageBitmap;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          resetPostPageState(ref);
          ref.read(postViewModelProvider.notifier).setImageError(null);
        }
      },
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              // title: Text(
              //   '投稿',
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     letterSpacing: 2.0,
              //   ),
              // ),
              backgroundColor: Colors.pink.shade100,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final picked =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (picked != null) {
                        _image = picked;
                        ref
                            .read(postViewModelProvider.notifier)
                            .setImageError(null);
                      }
                    },
                    child: const Text(
                      '画像を選択',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  if (imageBitmap != null) Image.memory(imageBitmap),
                  if (postState.imageError != null)
                    Text(
                      postState.imageError!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 12,
                      ),
                    ),
                  if (_image != null) Image.file(File(_image!.path)),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        TextFormField(
                          cursorColor: textColor,
                          controller: _nameController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: InputDecoration(
                            labelText: 'タイトル',
                            labelStyle: TextStyle(color: textColor),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: textColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: textColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.red), // エラー時の色
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'タイトルを入力してね！';
                            }
                            if (value.length > 10) {
                              return '10文字以内で入力してね！';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          dropdownColor: Colors.white,
                          value: _selectedPrefecture,
                          decoration: InputDecoration(
                            labelText: '県名',
                            labelStyle: TextStyle(color: textColor),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: textColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: textColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.red), // エラー時の色
                            ),
                          ),
                          style: TextStyle(color: textColor),
                          items: _prefectures.map((String prefecture) {
                            return DropdownMenuItem<String>(
                              value: prefecture,
                              child: Text(prefecture),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            ref
                                .read(postViewModelProvider.notifier)
                                .setPrefecture(newValue);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '県名を選択してね！';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                          ),
                          onPressed: () {
                            final notifier =
                                ref.read(postViewModelProvider.notifier);
                            // 画像が未選択ならエラーをセット
                            if (_image == null) {
                              notifier.setImageError('画像が選択されていないよ！');
                            } else {
                              notifier.setImageError(null);
                            }

                            // フォームバリデーション
                            if (_formKey.currentState!.validate() &&
                                _image != null) {
                              notifier.saveToFirebase(
                                title: _nameController.text,
                                prefectureName: ref
                                    .read(postViewModelProvider)
                                    .selectedPrefecture,
                                image: _image,
                              );
                            }
                          },
                          child: Text(
                            '投稿',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (postState.isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
