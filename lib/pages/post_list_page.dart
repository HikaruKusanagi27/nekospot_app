import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/pages/post_page.dart';
import 'dart:developer' as developer;
import '../models/post_info.dart';
import '../providers/post_provider.dart';

class PostListPage extends StatelessWidget {
  const PostListPage({super.key});

  // 共通の色を定義
  static const textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        title: Center(
          child: Text(
            'みんなの投稿',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
      body: Center(
        child: _PostSection(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostPage(),
              fullscreenDialog: true,
            ),
          );
        },
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
        if (posts.isEmpty) {
          return const Center(
            child: Text(
              '投稿がありません',
              style: TextStyle(fontSize: 16),
            ),
          );
        }
        return SingleChildScrollView(
          child: ListView.builder(
            itemCount: posts.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _PostList(posts[index]);
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) {
        developer.log('PostListPage エラー: $error',
            error: error, stackTrace: stack);
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                const SizedBox(height: 16),
                Text(
                  'データの読み込みに失敗しました',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'エラー: $error',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
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
    return Card(
      color: Colors.pink.shade100,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            data.imagePath.isNotEmpty
                ? Image.network(data.imagePath)
                : Image.asset('images/noimage-760x460.png'), // 画像がない場合のプレースホルダー

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    SizedBox(
                      width: 35,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset('images/free-neko.jpeg'),
                      ),
                    ),
                    Text(
                      'ななしのネコさん',
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
                          '場所: ${data.prefectureName}',
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
      ),
    );
  }
}
