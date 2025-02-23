import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/post_info.dart';

final postStreamProvider = StreamProvider<List<PostInfo>>((ref) {
  return FirebaseFirestore.instance
      .collection('posts')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return PostInfo(
        imagePath: data['imageUrl'] ?? '',
        iconPath: 'images/neko.jpg',
        title: data['title'] ?? '未設定',
        subTitle: '${data['prefecture']} / ${data['place']}',
      );
    }).toList();
  });
});
