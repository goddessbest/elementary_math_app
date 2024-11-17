import 'package:flutter/material.dart';

class GradeSelectionScreen extends StatefulWidget {
  @override
  _GradeSelectionScreenState createState() => _GradeSelectionScreenState();
}

class _GradeSelectionScreenState extends State<GradeSelectionScreen> {
  int? selectedGrade; // 현재 선택된 학년 (null일 경우 아무 학년도 선택되지 않음)

  @override
  Widget build(BuildContext context) {
    // 화면 크기 가져오기
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 버튼 간격과 크기 설정
    final spacing = screenWidth * 0.06; // 버튼 간의 간격 (화면 너비의 6%)
    final buttonHeight = (screenHeight - spacing * 10) / 12;
    final buttonWidth = screenWidth * 0.8; // 학년 버튼의 가로 크기

    return Scaffold(
      body: Column(
        children: [
          // 상단 타이틀
          Container(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
            color: Colors.blue,
            width: double.infinity,
            child: Center(
              child: Text(
                '학년 선택',
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // 학년 버튼들
          Expanded(
            child: ListView.builder(
              itemCount: 6, // 학년 수
              padding: EdgeInsets.symmetric(horizontal: spacing, vertical: spacing),
              itemBuilder: (context, index) {
                int grade = index + 1; // 학년 계산
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          // 같은 학년을 다시 터치하면 학기 버튼 감춤
                          if (selectedGrade == grade) {
                            selectedGrade = null;
                          } else {
                            selectedGrade = grade; // 다른 학년을 선택하면 업데이트
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedGrade == grade
                            ? Colors.blueAccent.shade700
                            : Colors.blueAccent, // 선택된 학년 강조 색상
                        minimumSize: Size(buttonWidth, buttonHeight),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.03),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '$grade학년',
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // 학년 버튼과 학기 버튼 사이 간격
                    if (selectedGrade == grade) SizedBox(height: spacing / 2),
                    // 학기 버튼 표시
                    if (selectedGrade == grade) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              print('$grade학년 1학기 선택됨');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              minimumSize: Size(buttonWidth / 2.5, buttonHeight / 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(screenWidth * 0.03),
                              ),
                            ),
                            child: Text(
                              '1학기',
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: spacing), // 학기 버튼 간 간격
                          ElevatedButton(
                            onPressed: () {
                              print('$grade학년 2학기 선택됨');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              minimumSize: Size(buttonWidth / 2.5, buttonHeight / 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(screenWidth * 0.03),
                              ),
                            ),
                            child: Text(
                              '2학기',
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spacing), // 학기 버튼 아래 간격
                    ],
                    // 학년 버튼 사이 간격
                    SizedBox(height: spacing),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
