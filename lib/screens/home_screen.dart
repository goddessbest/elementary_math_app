import 'package:flutter/material.dart';
import 'grade_selection_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'assets/splash.png', // 홈 화면 배경 이미지
              fit: BoxFit.cover,
            ),
          ),
          // 하단 버튼
          Align(
            alignment: Alignment(0.0, 0.8), // 가로 중앙, 세로 하단에 배치
            child: ElevatedButton(
              onPressed: () {
                // 학년 선택 화면으로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GradeSelectionScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // 버튼 배경색
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // 둥근 버튼
                ),
              ),
              child: Text(
                '시작하기',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
