// lib/screens/detail_screen.dart

import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String categoryTitle;

  const DetailScreen({
    super.key,
    required this.categoryTitle,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // 3. '상세 내역'을 담을 리스트 (React의 useState([]))
  final List<String> detailData = [];

  // 4. React의 useEffect(..., [])
  @override
  void initState() {
    super.initState();
    
    // 5. 'categoryTitle'을 기반으로 1000개의 가짜 데이터를 생성합니다.
    for (int i = 0; i < 1000; i++) {
      // widget.categoryTitle : StatefulWidget의 prop을 가져오는 방식
      detailData.add("${widget.categoryTitle} 데이터 ${i + 1}");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 2. 받은 제목으로 AppBar를 만듭니다.
      appBar: AppBar(
        // prop을 가져올 땐 'widget.'을 붙여야 합니다.
        title: Text(widget.categoryTitle), // 예: '걸음', '수면'
      ),
      // 6. [핵심] body를 ListView.builder로 변경
      //    이것이 RN의 <FlatList data={...} renderItem={...} /> 입니다.

      body: ListView.builder(
        // 7. data.length
        itemCount: detailData.length,
        
        // 8. renderItem
        itemBuilder: (BuildContext context, int index) {
          // 9. 'ListTile'은 목록 아이템을 만들기 위한 표준 위젯입니다.
          //    (아이콘, 제목, 부제목을 깔끔하게 배치해 줌)
          return ListTile(
            leading: const Icon(Icons.check_circle_outline),
            title: Text(detailData[index]),
            subtitle: Text('2025년 10월 30일, $index'),
          );
        },
      ),
    );
  }
}