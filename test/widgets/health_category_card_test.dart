// test/widgets/health_category_card_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firstapp/widgets/health_category_card.dart'; // 1. 테스트할 위젯 import

void main() {
  // testWidgets()는 RN의 test() 또는 it()과 같습니다.
  // 'WidgetTester tester'는 RN의 'render()'가 반환하는
  // 'screen', 'getByText' 등의 헬퍼 객체와 같습니다.
  testWidgets('HealthCategoryCard는 props를 올바르게 렌더링해야 한다', (WidgetTester tester) async {
    
    // 1. Arrange (준비): 테스트할 mock props를 준비합니다.
    const mockTitle = '테스트 제목';
    const mockValue = '100 BPM';
    const mockIcon = Icons.favorite;

    // 2. Act (실행): 위젯을 '가상'으로 렌더링(pump)합니다.
    //    RN의 render(<HealthCategoryCard ... />)와 같습니다.
    //    [중요] HealthCategoryCard는 MaterialApp(테마 등) 안에서
    //    렌더링되어야 하므로, Scaffold/MaterialApp으로 감싸줍니다.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HealthCategoryCard(
            title: mockTitle,
            value: mockValue,
            time: '방금 전',
            icon: mockIcon,
            iconColor: Colors.red,
            onDelete: () {},
            onTap: () {},
          ),
        ),
      ),
    );

    // 3. Assert (검증): 렌더링된 결과를 확인합니다.
    
    // 3-1. '테스트 제목'이라는 텍스트를 찾습니다.
    //      (RN의 screen.getByText('테스트 제목')과 같음)
    final titleFinder = find.text(mockTitle);
    
    // 3-2. '100 BPM'이라는 텍스트를 찾습니다.
    final valueFinder = find.text(mockValue);

    // 3-3. 'favorite' 아이콘을 찾습니다.
    //      (RN의 screen.getByTestId('icon-favorite')와 비슷)
    final iconFinder = find.byIcon(mockIcon);

    // 3-4. [검증] '테스트 제목'이 1개 있는지 확인합니다.
    //      (RN의 expect(screen.getByText(...)).toBeInTheDocument()와 같음)
    expect(titleFinder, findsOneWidget);
    
    // 3-5. [검증] '100 BPM'이 1개 있는지 확인합니다.
    expect(valueFinder, findsOneWidget);

    // 3-6. [검증] 아이콘이 1개 있는지 확인합니다.
    expect(iconFinder, findsOneWidget);
  });
}