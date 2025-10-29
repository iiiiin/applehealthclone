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
      ),
      // 11. 화면의 본문 영역
      body: Center(
        // 12. 우선은 '여기에 격자가 들어온다'는 텍스트만 띄웁니다.
        child: const Text('여기에 GridView가 들어올 예정입니다.'),
      ),
    );
  }
}