// lib/screens/summary_screen.dart

// 1. material.dart는 기본
import 'package:flutter/material.dart';

// 2. [중요] 방금 분리한 HealthCategoryCard를 import 합니다.
//    (React에서 'import HealthCategoryCard from "../widgets/HealthCategoryCard";'와 같음)
import '../widgets/health_category_card.dart';

// 8. '요약' 탭에 해당하는 실제 화면 위젯입니다.
//    (지금은 한 파일에 있지만, 나중엔 별도 파일로 분리할 겁니다.)
class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  // 4. '상태' 선언: build() 밖에 데이터를 선언합니다!
  // React의 const [healthData, setHealthData] = useState([...]); 와 동일.
  // 이 데이터를 'state'라고 부릅니다.
  // 'final'을 지워야 나중에 데이터를 변경할 수 있습니다.
  List<Map<String, dynamic>> healthData = []; // <--- 1. 빈 리스트로 선언

  // 5. 'initState()' 메소드를 추가합니다.
  // 이것은 React의 useEffect(..., []) 와 100% 같습니다.
  // 위젯이 '처음 생성될 때' 딱 한 번 호출됩니다.
  // API 호출, 데이터 초기화 등은 여기서 합니다.
  @override
  void initState() {
    super.initState(); // 부모 initState() 호출 (필수)
    
    // 6. 여기서 '상태'를 초기화합니다.
    // (지금은 하드코딩, 나중엔 여기서 API 통신)
    healthData = [
      {
        'title': '심박수',
        'value': '75 BPM',
        'time': '방금 전',
        'icon': Icons.favorite,
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
  }
  @override
  Widget build(BuildContext context) {
    // 8. build() 안에 있던 'healthData' 리스트는 밖으로 나갔으므로 삭제!

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
        
        // 9. itemCount와 itemBuilder는 이제 build 밖의 '상태' 변수를 바라봅니다.
        itemCount: healthData.length,
        itemBuilder: (BuildContext context, int index) {
          final data = healthData[index];

          // 4. HealthCategoryCard에 'onDelete' prop을 새로 전달합니다.
          return HealthCategoryCard(
            title: data['title'],
            value: data['value'],
            time: data['time'],
            icon: data['icon'],
            iconColor: data['color'],
            // 5. 꾹 눌렀을 때 실행될 함수를 전달합니다.
            //    React의 <Card onDelete={() => _deleteHealthData(index)} /> 와 동일.
            onDelete: () => _deleteHealthData(index),
          );
        },
      ),
      // 1. 이 부분을 추가합니다. (body: ... , 뒤에)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 2. 버튼이 눌렸을 때 실행할 로직 (아래 2단계에서 채울 것)
          _addHealthData();
        },
        child: const Icon(Icons.add), // 버튼 아이콘
      ),
    );
  }
  // 3. _addHealthData 메소드를 build 메소드 *밖에* 추가합니다.
  //    (React에서 렌더 함수 밖에 헬퍼 함수를 빼는 것과 같음)
  void _addHealthData() {
    // 4. 이것이 바로 React의 setHealthData(...) 입니다!
    setState(() {
      // 5. setState() 콜백 함수 '안'에서 상태(state)를 직접 변경합니다.
      //    (React의 불변성과 달리, Dart는 리스트를 직접 '수정(mutate)'해도 됨)
      healthData.add({
        'title': '새 항목',
        'value': '${healthData.length + 1} 번째',
        'time': '방금',
        'icon': Icons.new_releases,
        'color': Colors.green,
      });
    });
  }
  // 1. _addHealthData 메소드 아래에 '삭제' 메소드를 추가합니다.
  void _deleteHealthData(int indexToDelete) {
    // 2. setState()로 Flutter에게 상태 변경을 알립니다.
    setState(() {
      // 3. 'indexToDelete'에 해당하는 항목을 리스트에서 제거합니다.
      healthData.removeAt(indexToDelete);
    });
  }
}