import 'package:flutter/material.dart';
import 'dart:math';

class Grade2Semester1Screen extends StatefulWidget {
  @override
  _Grade2Semester1ScreenState createState() => _Grade2Semester1ScreenState();
}

class _Grade2Semester1ScreenState extends State<Grade2Semester1Screen> {
  final Random _random = Random();
  final List<Map<String, dynamic>> _questions = [];
  final List<TextEditingController> _controllers = [];
  int _score = 0;
  bool _showScore = false;
  String _selectedOperation = '덧셈'; // 초기값: 덧셈

  @override
  void initState() {
    super.initState();
    _generateQuestions();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  // 문제 생성 함수
  void _generateQuestions() {
    _questions.clear();
    _controllers.clear();
    for (int i = 0; i < 10; i++) {
      int num1, num2;

      if (_selectedOperation == '뺄셈') {
        // 뺄셈 문제: 두 자리 숫자, 0을 빼는 문제는 제외
        num1 = _random.nextInt(90) + 10; // 10부터 99까지
        num2 = _random.nextInt(num1 - 9) + 10; // num2 <= num1, 10부터 시작
        _questions.add({'num1': num1, 'num2': num2, 'answer': num1 - num2});
      } else if (_selectedOperation == '덧셈') {
        // 덧셈 문제: 두 자리 숫자, 결과가 100 초과
        do {
          num1 = _random.nextInt(90) + 10; // 10부터 99까지
          num2 = _random.nextInt(90) + 10; // 10부터 99까지
        } while (num1 + num2 <= 100); // 합이 100보다 큰 경우만 허용
        _questions.add({'num1': num1, 'num2': num2, 'answer': num1 + num2});
      } else if (_selectedOperation == '곱셈') {
        // 곱셈 문제: 한 자리 숫자, 0을 곱하지 않음
        do {
          num1 = _random.nextInt(9) + 1; // 1부터 9까지
          num2 = _random.nextInt(9) + 1; // 1부터 9까지
        } while (num1 == 0 || num2 == 0); // 0을 곱하지 않음
        _questions.add({'num1': num1, 'num2': num2, 'answer': num1 * num2});
      }

      _controllers.add(TextEditingController());
    }
  }

  // 정답 확인 함수
  void _checkAnswers() {
    setState(() {
      _score = 0;
      for (int i = 0; i < _questions.length; i++) {
        int correctAnswer = _questions[i]['answer'];
        int userAnswer =
            int.tryParse(_controllers[i].text.trim()) ?? -1; // 잘못된 입력은 -1로 처리
        if (userAnswer == correctAnswer) {
          _score++;
        }
      }
      _showScore = true;
    });
  }

  // 퀴즈 리셋 함수
  void _resetQuiz() {
    setState(() {
      _generateQuestions();
      _showScore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '2학년 1학기 - $_selectedOperation 문제',
              style: TextStyle(fontSize: 18),
            ),
            DropdownButton<String>(
              value: _selectedOperation,
              dropdownColor: Colors.blue,
              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
              underline: SizedBox(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOperation = newValue!;
                  _generateQuestions(); // 문제 새로 생성
                });
              },
              items: <String>['덧셈', '뺄셈', '곱셈']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: _showScore
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '점수: $_score / 10',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _resetQuiz,
                    child: Text('다시 풀기'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.2, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _questions.length,
                      itemBuilder: (context, index) {
                        final question = _questions[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${question['num1']} ${_selectedOperation == '곱셈' ? 'x' : (_selectedOperation == '덧셈' ? '+' : '-')} ${question['num2']} = ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                width: 60,
                                child: TextField(
                                  controller: _controllers[index],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _checkAnswers,
                    child: Text('제출'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.3, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
