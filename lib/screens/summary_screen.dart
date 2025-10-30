// lib/screens/summary_screen.dart

// 1. material.dart는 기본
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. Provider import
import '../widgets/health_category_card.dart';
import 'detail_screen.dart';
import '../providers/health_data_provider.dart'; // 2. Provider import


// 3. 'StatefulWidget'에서 'StatelessWidget'으로 다시 변경!
class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    // 1. [중요] build 메소드 최상단에서 'watch'를 제거합니다!
    //    이제 'build'는 '+' 버튼을 눌러도 리빌드되지 않습니다.

    return Scaffold(
      appBar: AppBar(
        title: const Text('요약 (Optimized)'), // (제목 변경해서 확인)
        backgroundColor: Colors.grey[100],
        // 2. AppBar는 이제 절대 리빌드되지 않습니다! (const 아님에도)
      ),
      // 3. [핵심] GridView.builder를 'Consumer' 위젯으로 감쌉니다.
      //    'Consumer'는 Provider를 '구독'하는 전용 위젯입니다.
      body: Consumer<HealthDataProvider>(
        // 4. 'builder'는 React의 'Render Prop'과 같습니다.
        //    'healthProvider'는 provider의 상태, 'child'는 최적화용
        builder: (context, healthProvider, child) {

        // 5. 이 builder 함수 안쪽만 리빌드됩니다!
          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              childAspectRatio: 1.0,
            ),
            itemCount: healthProvider.healthData.length,
            itemBuilder: (BuildContext context, int index) {
              final data = healthProvider.healthData[index];

              return HealthCategoryCard(
                title: data['title'],
                value: data['value'],
                time: data['time'],
                icon: data['icon'],
                iconColor: data['color'],
                onDelete: () {
                  // 6. 'read'는 Consumer 바깥에서도 쓸 수 있습니다.
                  context.read<HealthDataProvider>().deleteHealthData(index);
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        categoryTitle: data['title'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 7. 'read'는 여전히 잘 동작합니다.
          context.read<HealthDataProvider>().addHealthData();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
