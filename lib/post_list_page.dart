import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/post_page.dart';
import 'dart:developer' as developer;
import 'models/post_info.dart';
import 'providers/post_provider.dart';

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

class _PostSection extends ConsumerWidget {
  const _PostSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(postStreamProvider);

    return postsAsync.when(
      data: (posts) {
        return ListView.builder(
          itemCount: posts.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _PostList(posts[index]);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) {
        developer.log('PostListPage エラー: $error',
            error: error, stackTrace: stack);
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('データの読み込みに失敗しました。\nエラー: $error',
                textAlign: TextAlign.center),
          ),
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
      padding: const EdgeInsets.only(top: 10, right: 10, bottom: 10),
      child: Column(
        children: [
          data.imagePath.isNotEmpty
              ? Image.network(data.imagePath)
              : const Placeholder(), // 画像がない場合のプレースホルダー
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset('images/neko.jpg'),
                    ),
                  ),
                  Text(
                    'ななしの猫さん',
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'タイトル: ${data.title}',
                        style: const TextStyle(
                          color: textColor,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 54),
                      Text(
                        '場所: ${data.place}',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
