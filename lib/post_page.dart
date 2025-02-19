import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '未設定';
  String _prefectures = '未設定';
  String _place = '未設定';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _prefecturesController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  static const textColor = Colors.black;

  XFile? _image;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
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
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('画像を選択'),
            ),
            if (_image != null) Image.file(File(_image!.path)),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'タイトル',
                      labelStyle: TextStyle(color: textColor),
                    ),
                    style: TextStyle(color: textColor),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'タイトルを入力してね！';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _prefecturesController,
                    decoration: InputDecoration(
                      labelText: '県名',
                      labelStyle: TextStyle(color: textColor),
                    ),
                    style: const TextStyle(color: textColor),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '県名を入力してね！';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _placeController,
                    decoration: InputDecoration(
                      labelText: '場所',
                      labelStyle: TextStyle(color: textColor),
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await _saveToFirebase();
                      }
                    },
                    child: const Text('保存',
                        style: TextStyle(
                          color: textColor,
                        )),
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
        'prefecture': _prefecturesController.text,
        'place': _placeController.text,
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      print('Error saving to Firebase: $e');
    }
  }
}
