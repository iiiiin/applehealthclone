// lib/widgets/health_category_card.dart

// 1. material.dart를 import 해야 Widget, BuildContext 등을 인식합니다.
//    (React에서 'import React from "react";'와 같음)
import 'package:flutter/material.dart';


class HealthCategoryCard extends StatelessWidget {
  // 1. 'props'를 선언합니다.
  // Dart에서는 'final' 키워드를 사용해 불변(immutable) props를 만듭니다.
  final String title;
  final String value;
  final String time;
  final IconData icon; // Icon 데이터를 직접 받습니다 (예: Icons.favorite)
  final Color iconColor;

  // 1. 'onDelete' 함수 prop을 추가합니다.
  //    'VoidCallback'은 '파라미터 없고 리턴값 없는 함수'를 의미합니다.
  //    (React의 '() => void' 타입과 같음)
  //    '?'는 null일 수도 있다는 의미 (선택적 prop)
  final VoidCallback? onDelete;

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
    this.onDelete, // 2. 생성자에 'onDelete'를 추가합니다 (required 아님)
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
      // 3. Card의 자식(child)을 'InkWell' 위젯으로 감쌉니다.
      //    'InkWell'은 'onTap', 'onLongPress' 등을 감지하고 
      //    물결 효과(ripple effect)를 줍니다.
      //    (React Native의 <TouchableOpacity>와 비슷)
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0), // 물결 효과가 Card 모양과 맞도록
        
        // 4. 'onLongPress' 이벤트에 'onDelete' prop을 연결합니다.
        onLongPress: onDelete,
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
    )
    );
  }
}