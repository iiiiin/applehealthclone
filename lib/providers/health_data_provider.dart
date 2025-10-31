import 'package:flutter/material.dart';

// 1. 'ChangeNotifier'를 import 합니다. (Provider의 핵심)
//    이것이 React의 'useState'의 'set' 함수처럼 "알림" 기능을 합니다.
class HealthDataProvider with ChangeNotifier {
  
  // 1. [추가] 로딩 상태 변수. 기본값은 'true'(로딩 중)
  bool _isLoading = true;

  // 2. [추가] 로딩 상태를 외부에서 읽을 수 있는 getter
  bool get isLoading => _isLoading;
  
  // 1. [추가] 에러 메시지를 저장할 상태 변수
  String? _error;
  // 2. [추가] 에러 상태를 외부에서 읽을 getter
  String? get error => _error;

  // 3. 데이터 변수는 빈 리스트로 초기화
  List<Map<String, dynamic>> _healthData = [];
  List<Map<String, dynamic>> get healthData => _healthData = [];

  // 4. initState에서 하던 초기화 로직을 '생성자'로 옮깁니다.
  HealthDataProvider() {
    // 생성자에서는 비동기 작업을 직접 기다릴 수 없으므로,
    // 'fetchData'라는 별도 비동기 함수를 호출합니다.
    _fetchData();
  }

  // 5. [추가] 데이터를 가져오는 비동기 함수 (가짜 API 호출)
  Future<void> _fetchData() async {
    // 6. (선택 사항) 혹시 모르니 로딩 시작을 알림. (이미 true지만 명시적)
    _isLoading = true;
    _error = null; // 3. [추가] API 호출 전 에러 상태 초기화
    notifyListeners(); 

    try {
      // 7. [핵심] 3초간 대기 (API 호출 시뮬레이션)
      await Future.delayed(const Duration(seconds: 3));

      // 5. [수정] 3초 후, 데이터 로드 대신 고의로 에러 발생!
      throw Exception('인터넷 연결이 끊겼습니다. (시뮬레이션)');      
    } catch (e) {
      // 7. [추가] 에러가 잡혔을 때 실행
      _isLoading = false; // 로딩은 끝났고
      _error = e.toString(); // 에러 상태에 메시지 저장
    }
    

    // _healthData = [
    //   // ... (SummaryScreen의 initState에 있던 데이터 리스트 복사) ...
    //    {
    //     'title': '심박수',
    //     'value': '75 BPM',
    //     'time': '방금 전',
    //     'icon': Icons.favorite,
    //     'color': Colors.red,
    //   },
    //   // ... (나머지 데이터 5개도 여기에 복사) ...
    //    {
    //     'title': '걸음',
    //     'value': '4,820',
    //     'time': '오늘',
    //     'icon': Icons.directions_walk,
    //     'color': Colors.orange,
    //   },
    //   {
    //     'title': '수면',
    //     'value': '6시간 45분',
    //     'time': '어젯밤',
    //     'icon': Icons.nightlight_round,
    //     'color': Colors.purple,
    //   },
    //   {
    //     'title': '체중',
    //     'value': '70.5 kg',
    //     'time': '오전 8:00',
    //     'icon': Icons.monitor_weight,
    //     'color': Colors.blue,
    //   },
    //   {
    //     'title': '활동 에너지',
    //     'value': '350 kcal',
    //     'time': '오늘',
    //     'icon': Icons.local_fire_department,
    //     'color': Colors.redAccent,
    //   },
    //   {
    //     'title': '물',
    //     'value': '1.2 L',
    //     'time': '오늘',
    //     'icon': Icons.water_drop,
    //     'color': Colors.lightBlue,
    //   },
    // ];
    // 9. [핵심] 데이터 로딩이 끝났으니 'isLoading'을 false로 변경
    // _isLoading = false;
    // 10. "로딩 끝났고 데이터 준비됐어!"라고 구독자(Consumer)에게 알림
    notifyListeners();
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