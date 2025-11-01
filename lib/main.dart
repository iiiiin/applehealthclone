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
      // 1. [핵심] 'theme' 속성을 확장합니다.
      theme: ThemeData(
        // 2. 앱의 기본 색상 견본 (Swatch)
        //    이걸 'blue'로 설정하면 버튼, 스피너 등이 자동으로 파란색이 됩니다.
        primarySwatch: Colors.blue,

        // 3. AppBar, Scaffold 등 전역 배경색 지정
        scaffoldBackgroundColor: Colors.grey[50], // 약간의 회색 배경
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[50], // AppBar 배경도 통일
          foregroundColor: Colors.black, // AppBar 글자색 (기본은 흰색)
          elevation: 0, // AppBar 그림자 제거
        ),
        
        // 4. [중요] 전역 텍스트 스타일 정의
        textTheme: const TextTheme(
          // '걸음', '수면' 같은 카드 제목용
          titleMedium: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.black87,
          ),
          // '4,820', '75 BPM' 같은 큰 값 표시용
          headlineSmall: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
          // '오늘', '방금 전' 같은 작은 시간 표시용
          bodySmall: TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
          ),
        ),
      ),
      home: const SummaryScreen(),
    );
  }
}