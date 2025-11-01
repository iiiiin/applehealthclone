import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:http/http.dart' as http; // 1. [추가] http 패키지 import
import 'dart:convert';                  // 2. [추가] JSON 파싱을 위한 import

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
  List<Map<String, dynamic>> get healthData => _healthData;

  // 4. initState에서 하던 초기화 로직을 '생성자'로 옮깁니다.
  HealthDataProvider() {
    // 생성자에서는 비동기 작업을 직접 기다릴 수 없으므로,
    // 'fetchData'라는 별도 비동기 함수를 호출합니다.
    _fetchData();
  }

   // 1. [추가] 안전하게 문자열을 자르는 헬퍼 함수
  String _safeSubstring(String text, int length) {
    if (text.length < length) {
      return text; // ⬅️ 길이가 짧으면, 그냥 원본을 반환
    }
    return text.substring(0, length); // ⬅️ 길이가 길 때만 자름
  }
   
  // 5. [추가] 데이터를 가져오는 비동기 함수 (가짜 API 호출)
  Future<void> _fetchData() async {
    // 6. (선택 사항) 혹시 모르니 로딩 시작을 알림. (이미 true지만 명시적)
    _isLoading = true;
    _error = null; // 3. [추가] API 호출 전 에러 상태 초기화
    notifyListeners(); 

    try {
      // 3. [수정] HealthKit 권한 요청 대신 API URL로 GET 요청
      final url = Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=6');
      final response = await http.get(url).timeout(const Duration(seconds: 5));

      // 4. [수M] API 응답 확인
      if (response.statusCode == 200) {
        // 5. [추가] String 응답을 JSON(List<dynamic>)으로 파싱
        final List<dynamic> jsonData = jsonDecode(response.body);

      // 6. [수정] JSON 데이터를 우리 앱의 Map 구조로 변환
        _healthData = jsonData.map((post) {
          // JSONPlaceholder의 'title'과 'body'를 우리 앱의 'title'과 'value'로 매핑
          return {
            'title': _safeSubstring(post['title'].toString(), 15),
            'value': _safeSubstring(post['body'].toString(), 20),
            'time': 'API 수신',
            'icon': Icons.http, // 아이콘 변경
            'color': Colors.deepPurple,
          };
        }).toList(); // List<Map<...>>로 변환

      _isLoading = false;
      } else {
        // 7. [수정] 서버가 에러 코드를 보낸 경우
        throw Exception('API 서버 에러: ${response.statusCode}');
      }
    } catch (e) {
      // 7. [추가] 에러가 잡혔을 때 실행
      _isLoading = false; // 로딩은 끝났고
      _error = e.toString(); // 에러 상태에 메시지 저장
    }
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