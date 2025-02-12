import 'package:flutter/material.dart';
import 'package:test/post_page.dart';

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
  _PostSection();

  final List<PostInfo> _dummyMovieData = [
    PostInfo(
      imagePath: 'images/nekocyanPAKE4725-457_TP_V.webp',
      iconPath: 'images/スクリーンショット 2024-11-28 19.30.27.png',
      title: 'アメショー',
      subTitle: '東京/とある公園',
    ),
    PostInfo(
      imagePath: 'images/tomcatDSC09085_TP_V.webp',
      iconPath: 'images/スクリーンショット 2024-11-28 19.30.27.png',
      title: 'アメショー',
      subTitle: '神奈川/とある公園',
    ),
    PostInfo(
      imagePath: 'images/tomneko12151294_TP_V.webp',
      iconPath: 'images/スクリーンショット 2024-11-28 19.30.27.png',
      title: 'アメショー',
      subTitle: '神奈川/とある公園',
    ),
    PostInfo(
      imagePath: 'images/スクリーンショット 2024-11-28 19.30.27.png',
      iconPath: 'images/tomneko12151294_TP_V.webp',
      title: 'アメショー',
      subTitle: '神奈川/とある公園',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          itemCount: _dummyMovieData.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final data = _dummyMovieData[index];
            return _PostList(data);
          },
        ),
      ],
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
          Image.asset(data.imagePath),
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
