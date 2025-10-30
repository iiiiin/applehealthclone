// lib/screens/detail_screen.dart

import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  // 1. 카테고리 제목을 prop으로 받습니다.
  final String categoryTitle;

  const DetailScreen({
    super.key,
    required this.categoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 2. 받은 제목으로 AppBar를 만듭니다.
      appBar: AppBar(
        title: Text(categoryTitle), // 예: '걸음', '수면'
      ),
      body: Center(
        // 3. 이곳에 나중에 ListView.builder로 상세 내역을 채울 겁니다.
        child: Text('$categoryTitle 상세 내역'),
      ),
    );
  }
}