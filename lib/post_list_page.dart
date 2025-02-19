import 'package:flutter/material.dart';
import 'package:test/post_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostListPage extends StatelessWidget {
  const PostListPage({super.key});

  // 共通の色を定義
  static const textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            '戻る',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: null,
            icon: const Icon(null),
          ),
        ],
        automaticallyImplyLeading: false,
        title: Center(
          child: const Text(
            '😽みんなの投稿😽',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: textColor,
            ),
          ),
        ),
        backgroundColor: Colors.pink.shade100,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _PostSection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostPage(),
              fullscreenDialog: true,
            ),
          );
        },
        backgroundColor: Colors.pink.shade200,
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}

// 1. データクラスを作成
class PostInfo {
  PostInfo({
    required this.imagePath,
    required this.iconPath,
    required this.title,
    required this.subTitle,
  });
  final String imagePath; // サムネイル画像のパス
  final String iconPath; // アイコン画像のパス
  final String title; // 動画タイトル
  final String subTitle; // サブタイトル
}

// 2. ダミーデータの作成
class _PostSection extends StatelessWidget {
  const _PostSection();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // リアルタイムでデータを取得
      stream: FirebaseFirestore.instance
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('エラーが発生しました'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final posts = snapshot.data!.docs;

        return ListView.builder(
          itemCount: posts.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final data = posts[index].data() as Map<String, dynamic>;
            return _PostList(
              PostInfo(
                imagePath: data['imageUrl'] ?? '',
                iconPath:
                    'images/スクリーンショット 2024-11-28 19.30.27.png', // デフォルトアイコン
                title: data['title'] ?? '未設定',
                subTitle: '${data['prefecture']} / ${data['place']}',
              ),
            );
          },
        );
      },
    );
  }
}

class _PostList extends StatelessWidget {
  const _PostList(this.data);
  final PostInfo data;
  static const textColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink[100],
      child: Column(
        children: [
          data.imagePath.isNotEmpty
              ? Image.network(data.imagePath)
              : const Placeholder(), // 画像がない場合のプレースホルダー
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(data.iconPath),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      Text(
                        data.title,
                        style: const TextStyle(
                          color: textColor,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 54),
                      Text(
                        data.subTitle,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 10),
              const Column(
                children: [
                  Icon(Icons.more_vert, color: textColor),
                  SizedBox(height: 14),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
