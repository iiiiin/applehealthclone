// main.dart

// 1. Flutter의 머티리얼 디자인 UI 위젯을 가져옵니다.
// React의 'import React from 'react';'와 비슷합니다.
import 'package:flutter/material.dart';

// 2. 앱의 시작점입니다. (index.tsx의 ReactDOM.render와 유사)
void main() {
  // 3. 'MyApp' 위젯(컴포넌트)을 실행하라는 명령입니다.
  runApp(const MyApp());
}

// 4. 앱의 최상위 루트 위젯입니다. (App.tsx와 동일)
// 'const'는 성능을 위해 붙이며, 'StatelessWidget'은 React의
// state가 없는 함수형 컴포넌트와 같습니다.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 5. UI를 그리는 메소드입니다. (React의 render() 함수와 동일)
  @override
  Widget build(BuildContext context) {
    // 6. 'MaterialApp'은 앱 전체의 테마, 라우팅 등을 관리하는
    //    최상위 뼈대입니다. (React Native의 <NavigationContainer>와 유사)
    return MaterialApp(
      // (지금은 이 2개만 알면 됩니다)
      title: 'Apple Health Clone',
      theme: ThemeData(
        // 앱의 기본 색상 테마를 설정합니다.
        primarySwatch: Colors.blue,
      ),
      // 7. 앱이 처음 켜졌을 때 보여줄 '홈' 화면입니다.
      //    'SummaryScreen'이라는 위젯을 홈으로 지정합니다.
      home: const SummaryScreen(),
    );
  }
}


// 8. '요약' 탭에 해당하는 실제 화면 위젯입니다.
//    (지금은 한 파일에 있지만, 나중엔 별도 파일로 분리할 겁니다.)
class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 9. 'Scaffold'는 화면의 기본 구조(상단바, 본문 등)를 제공합니다.
    //    RN의 <SafeAreaView> + 헤더 + 본문 구조와 비슷합니다.
    return Scaffold(
      // 10. 상단 앱 바 (헤더)
      appBar: AppBar(
        // const: 이 텍스트는 절대 변하지 않으므로 const 처리 (성능 향상)
        title: const Text('요약'),
        backgroundColor: Colors.grey[100], // 애플 건강과 유사한 배경색
        // body를 GridView.builder로 변경합니다.
        // GridView.builder는 RN의 FlatList와 거의 같습니다.
        // 화면에 보이는 것만 그리는 효율적인 방식입니다.
      ),
      // 11. 화면의 본문 영역
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0), // 그리드 전체에 패딩
        
        // 1. 그리드의 레이아웃을 정의하는 핵심 부분
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,    // 한 줄에 2개의 열
          mainAxisSpacing: 16.0,  // 수직 간격
          crossAxisSpacing: 16.0, // 수평 간격
          childAspectRatio: 1.0,  // 아이템의 가로/세로 비율 (1.0 = 정사각형)
        ), 
        
        // 2. 총 몇 개의 아이템을 만들지? (우선 6개로 하드코딩)
        itemCount: 6,
        
        // 3. 각 아이템(셀)을 어떻게 그릴지?
        itemBuilder: (BuildContext context, int index) {
          // 'HealthCategoryCard'라는 위젯을 반환합니다.
          // (아래 2단계에서 이 위젯을 만들 겁니다.)
          // 지금은 임시로 Card를 넣습니다.
          return const HealthCategoryCard();
        },
      ),
    );
  }
}

// 2단계: 각 그리드 셀에 들어갈 위젯을 분리합니다.
// React에서 <HealthCategoryCard /> 컴포넌트를 분리하는 것과 같습니다.
// const 생성자를 사용해 리빌드를 방지합니다. (성능 최적화)
class HealthCategoryCard extends StatelessWidget {
  const HealthCategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Card 위젯은 RN의 <View style={{ shadow... }}>와 비슷합니다.
    // 적당한 그림자와 둥근 모서리를 제공합니다.
    return Card(
      elevation: 2.0, // 그림자 농도
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // 모서리 둥글기
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // 카드 내부 여백
        
        // Column은 RN의 <View style={{ flexDirection: 'column' }}>
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 위아래로 공간 분배
          children: [
            // 1. 아이콘 (지금은 임시 아이콘)
            // const: 이 아이콘은 절대 변하지 않으므로!
            const Icon(
              Icons.favorite, // '심박수' 아이콘 (임시)
              color: Colors.red,
              size: 32.0,
            ),
            
            // 2. 데이터 (지금은 임시 텍스트)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '심박수',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const Text(
                  '75 BPM',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900, // 가장 두껍게
                  ),
                ),
                const Text(
                  '방금 전',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}