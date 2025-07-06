import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'post_state.dart';

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
String? _imageError;
final _formKey = GlobalKey<FormState>();
final ImagePicker picker = ImagePicker();
final _nameController = TextEditingController();
final _placeController = TextEditingController();

class PostPage extends ConsumerWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 画像選択のためのImagePickerを追加

    const textColor = Colors.black;

    final postState = ref.watch(postViewModelProvider);
    final imageBitmap = postState.imageBitmap;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '投稿',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        backgroundColor: Colors.pink.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (imageBitmap != null) Image.memory(imageBitmap),
            if (postState.isLoading) const CircularProgressIndicator(),
            if (postState.errorMessage.isNotEmpty)
              Text(
                postState.errorMessage,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () =>
                  ref.read(postViewModelProvider.notifier).selectImage(),
              child: const Text('画像を選択', style: TextStyle(color: textColor)),
            ),
            if (postState.imageBitmap != null)
              ElevatedButton(
                onPressed: null,
                child: const Text('画像の編集', style: TextStyle(color: textColor)),
              ),
            if (_imageError != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _imageError!,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.error, fontSize: 12),
                ),
              ),
            if (_image != null) Image.file(File(_image!.path)),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    cursorColor: textColor,
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'タイトル',
                      labelStyle: TextStyle(color: textColor),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: textColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'タイトルを入力してね！';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    dropdownColor: Colors.white,
                    value: _selectedPrefecture,
                    decoration: InputDecoration(
                      labelText: '県名',
                      labelStyle: TextStyle(color: textColor),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: textColor),
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
                  TextFormField(
                    cursorColor: textColor,
                    controller: _placeController,
                    decoration: InputDecoration(
                      labelText: '場所',
                      labelStyle: TextStyle(color: textColor),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: textColor),
                      ),
                    ),
                    style: const TextStyle(color: textColor),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '場所を入力してね！';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      // setState(() {
                      //   _imageError = _image == null ? '画像を選択してね！' : null;
                      // });
                      // if (_formKey.currentState!.validate() && _image != null) {
                      //   await _saveToFirebase();
                      // }
                    },
                    child: const Text(
                      '保存',
                      style: TextStyle(
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveToFirebase() async {
    try {
      String? imageUrl;
      if (_image != null) {
        final fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('post_images')
            .child('$fileName.jpg');

        await storageRef.putFile(File(_image!.path));
        imageUrl = await storageRef.getDownloadURL();
      }

      await FirebaseFirestore.instance.collection('posts').add({
        'title': _nameController.text,
        'prefecture': _selectedPrefecture,
        'place': _placeController.text,
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });
      // Navigator.of(context).pop();
    } catch (e) {
      if (kDebugMode) {
        print('Error saving to Firebase: $e');
      }
    }
  }
}
