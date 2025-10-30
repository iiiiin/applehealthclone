// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. Provider import
import 'screens/summary_screen.dart';
import 'providers/health_data_provider.dart'; // 2. 방금 만든 Provider import

// 2. 앱의 시작점입니다. (index.tsx의 ReactDOM.render와 유사)
void main() {
  // 3. runApp()을 Provider로 감쌉니다.
  //    이것이 React의 <MyContext.Provider>입니다.
  // 3. 'MyApp' 위젯(컴포넌트)을 실행하라는 명령입니다.
  runApp(
    ChangeNotifierProvider(
      // 4. 'create'는 어떤 '상태 저장소'를 주입할지 알려줍니다.
      create: (context) => HealthDataProvider(),
      child: const MyApp(), // 5. 자식 위젯들 (MyApp 전체)
    ),
  );
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