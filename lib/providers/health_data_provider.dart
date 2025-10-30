import 'package:flutter/material.dart';

// 1. 'ChangeNotifier'를 import 합니다. (Provider의 핵심)
//    이것이 React의 'useState'의 'set' 함수처럼 "알림" 기능을 합니다.
class HealthDataProvider with ChangeNotifier {
  
  // 2. SummaryScreen의 'State'에 있던 데이터를 그대로 가져옵니다.
  //    'final'이 아닌 'private' 변수(_)로 바꿔서 외부 접근을 막습니다.
  List<Map<String, dynamic>> _healthData = [];

  // 3. 외부에서 데이터를 '읽기'만 할 수 있는 getter를 만듭니다.
  //    (React의 'selector'와 유사)
  List<Map<String, dynamic>> get healthData => _healthData;

  // 4. initState에서 하던 초기화 로직을 '생성자'로 옮깁니다.
  HealthDataProvider() {
    _healthData = [
      // ... (SummaryScreen의 initState에 있던 데이터 리스트 복사) ...
       {
        'title': '심박수',
        'value': '75 BPM',
        'time': '방금 전',
        'icon': Icons.favorite,
        'color': Colors.red,
      },
      // ... (나머지 데이터 5개도 여기에 복사) ...
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
  }

  // 5. SummaryScreen에 있던 '추가' 메소드를 가져옵니다.
  void addHealthData() {
    _healthData.add({
      'title': '새 항목',
      'value': '${_healthData.length + 1} 번째',
      'time': '방금',
      'icon': Icons.new_releases,
      'color': Colors.green,
    });
    
    // 6. [핵심] setState() 대신 'notifyListeners()'를 호출합니다.
    //    "나(HealthDataProvider)를 구독(watch)하는 위젯들아, 리빌드해!"
    notifyListeners();
  }

  // 7. SummaryScreen에 있던 '삭제' 메소드를 가져옵니다.
  void deleteHealthData(int indexToDelete) {
    _healthData.removeAt(indexToDelete);
    
    // 8. "구독자들에게 알려라!"
    notifyListeners();
  }
}