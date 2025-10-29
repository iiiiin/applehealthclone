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
    // 1. 임시 데이터 목록을 만듭니다. (React의 state나 const 변수와 같음)
    // Dart에서 리스트는 [], 맵(객체)은 {} 입니다.
    final List<Map<String, dynamic>> healthData = [
      {
        'title': '심박수',
        'value': '75 BPM',
        'time': '방금 전',
        'icon': Icons.favorite, // Icon 데이터
        'color': Colors.red,
      },
      {
        'title': '걸음',
        'value': '4,820',
        'time': '오늘',
        'icon': Icons.directions_walk,
        'color': Colors.orange,
      },
      {
        'title': '수면',
        'value': '6시간 45분',
        'time': '어젯밤',
        'icon': Icons.nightlight_round,
        'color': Colors.purple,
      },
      {
        'title': '체중',
        'value': '70.5 kg',
        'time': '오전 8:00',
        'icon': Icons.monitor_weight,
        'color': Colors.blue,
      },
      {
        'title': '활동 에너지',
        'value': '350 kcal',
        'time': '오늘',
        'icon': Icons.local_fire_department,
        'color': Colors.redAccent,
      },
      {
        'title': '물',
        'value': '1.2 L',
        'time': '오늘',
        'icon': Icons.water_drop,
        'color': Colors.lightBlue,
      },
    ];
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
        
        // 2. itemCount를 하드코딩된 6 대신 데이터 리스트의 길이로 변경
        itemCount: healthData.length,
        
        // 3. itemBuilder를 수정합니다.
        itemBuilder: (BuildContext context, int index) {
          // 4. 현재 index에 맞는 데이터를 가져옵니다.
          final data = healthData[index];

          // 5. 에러가 났던 HealthCategoryCard에 'props'를 전달합니다.
          //    (const는 더 이상 붙일 수 없습니다. 데이터가 동적이기 때문)
          return HealthCategoryCard(
            title: data['title'],
            value: data['value'],
            time: data['time'],
            icon: data['icon'],
            iconColor: data['color'],
          );
        },
      ),
    );
  }
}

// 2단계: 각 그리드 셀에 들어갈 위젯을 분리합니다.
// React에서 <HealthCategoryCard /> 컴포넌트를 분리하는 것과 같습니다.
// const 생성자를 사용해 리빌드를 방지합니다. (성능 최적화)
class HealthCategoryCard extends StatelessWidget {
  // 1. 'props'를 선언합니다.
  // Dart에서는 'final' 키워드를 사용해 불변(immutable) props를 만듭니다.
  final String title;
  final String value;
  final String time;
  final IconData icon; // Icon 데이터를 직접 받습니다 (예: Icons.favorite)
  final Color iconColor;

  // 2. 생성자(constructor)를 수정합니다.
  // this.title은 React의 props.title과 같습니다.
  // {super.key} 뒤에 콤마(,)를 찍고 받아올 props를 정의합니다.
  const HealthCategoryCard({
    super.key,
    required this.title, // required: 이 prop은 필수라는 의미
    required this.value,
    required this.time,
    required this.icon,
    required this.iconColor,
  });

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
            // 3. 하드코딩된 Icon을 'props'로 교체합니다.
            Icon(
              icon, // Icons.favorite 대신 props로 받은 icon
              color: iconColor, // Colors.red 대신 props로 받은 iconColor
              size: 32.0,
            ),
            
            // 4. 하드코딩된 Text들을 'props'로 교체합니다.
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title, // '심박수' 대신 props.title
                  style: const TextStyle( // Text도 const 가능
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  value, // '75 BPM' 대신 props.value
                  style: const TextStyle( // Text도 const 가능
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  time, // '방금 전' 대신 props.time
                  style: const TextStyle( // Text도 const 가능
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