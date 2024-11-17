import 'package:flutter/material.dart';
import '../screens/semester/grade1/semester1_screen.dart';
import '../screens/semester/grade1/semester2_screen.dart';
import '../screens/semester/grade2/semester1_screen.dart';

class GradeSelectionScreen extends StatefulWidget {
  @override
  _GradeSelectionScreenState createState() => _GradeSelectionScreenState();
}

class _GradeSelectionScreenState extends State<GradeSelectionScreen> {
  int? selectedGrade; // 현재 선택된 학년 (null일 경우 아무 학년도 선택되지 않음)

  // 학기별 문제 정보를 정의합니다.
  final Map<int, Map<String, dynamic>> semesterDetails = {
    1: {
      '1학기': "덧셈 문제",
      '2학기': ["덧셈", "뺄셈", "두자리 덧셈", "두자리 뺄셈"],
    },
    2: {
      '1학기': ["덧셈", "뺄셈", "곱셈"],
      '2학기': "문제 정보 없음",
    },
    3: {
      '1학기': "문제 정보 없음",
      '2학기': "문제 정보 없음",
    },
    4: {
      '1학기': "문제 정보 없음",
      '2학기': "문제 정보 없음",
    },
    5: {
      '1학기': "문제 정보 없음",
      '2학기': "문제 정보 없음",
    },
    6: {
      '1학기': "문제 정보 없음",
      '2학기': "문제 정보 없음",
    },
  };

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final spacing = screenWidth * 0.04; // 버튼 간 간격 조정
    final buttonHeight = screenHeight * 0.08; // 학기 버튼 높이를 이전 크기로 조정
    final buttonWidth = screenWidth * 0.35; // 학기 버튼 너비 조정

    return Scaffold(
      body: Column(
        children: [
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
          Expanded(
            child: ListView.builder(
              itemCount: semesterDetails.keys.length, // 모든 학년 표시
              padding:
                  EdgeInsets.symmetric(horizontal: spacing, vertical: spacing),
              itemBuilder: (context, index) {
                int grade = index + 1; // 학년 계산
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedGrade =
                              (selectedGrade == grade) ? null : grade;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedGrade == grade
                            ? Colors.blueAccent.shade700
                            : Colors.blueAccent,
                        minimumSize: Size(buttonWidth * 2, buttonHeight),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.03),
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
                    if (selectedGrade == grade) SizedBox(height: spacing / 2),
                    if (selectedGrade == grade) ...[
                      // 학기 버튼과 문제 설명 영역을 분리
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // 1학기 버튼
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Grade1Semester1Screen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              minimumSize: Size(buttonWidth, buttonHeight),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.03),
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
                          // 2학기 버튼
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Grade1Semester2Screen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              minimumSize: Size(buttonWidth, buttonHeight),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.03),
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
                      SizedBox(height: spacing / 2),
                      // 문제 설명 영역
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // 1학기 설명
                          Container(
                            width: buttonWidth,
                            child: _buildSemesterInfo(
                              semesterDetails[grade]?['1학기'],
                              screenWidth,
                              TextAlign.left,
                            ),
                          ),
                          // 2학기 설명
                          Container(
                            width: buttonWidth,
                            child: _buildSemesterInfo(
                              semesterDetails[grade]?['2학기'],
                              screenWidth,
                              TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spacing),
                    ],
                    SizedBox(height: spacing), // 학년 간 공백 추가
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSemesterInfo(
      dynamic details, double screenWidth, TextAlign align) {
    if (details is String) {
      return Text(
        "- $details",
        style: TextStyle(
          fontSize: screenWidth * 0.04,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: align,
      );
    } else if (details is List<String>) {
      return Column(
        crossAxisAlignment: align == TextAlign.left
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: details.map((type) {
          return Text(
            "- $type",
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            textAlign: align,
          );
        }).toList(),
      );
    }
    return SizedBox();
  }
}
