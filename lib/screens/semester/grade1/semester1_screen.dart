import 'package:flutter/material.dart';
import 'dart:math';

class Grade1Semester1Screen extends StatefulWidget {
  @override
  _Grade1Semester1ScreenState createState() => _Grade1Semester1ScreenState();
}

class _Grade1Semester1ScreenState extends State<Grade1Semester1Screen>
    with SingleTickerProviderStateMixin {
  final Random _random = Random();
  final List<Map<String, dynamic>> _questions = [];
  final List<TextEditingController> _controllers = [];
  int _score = 0;
  bool _showScore = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _generateQuestions();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _generateQuestions() {
    _questions.clear();
    _controllers.clear();
    for (int i = 0; i < 10; i++) {
      int num1 = _random.nextInt(10); // 0부터 9까지의 숫자
      int num2 = _random.nextInt(10 - num1); // num1 + num2 <= 10
      _questions.add({'num1': num1, 'num2': num2, 'answer': num1 + num2});
      _controllers.add(TextEditingController());
    }
  }

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
      _animationController.forward(from: 0);
    });
  }

  void _resetQuiz() {
    setState(() {
      _generateQuestions();
      _showScore = false;
      _animationController.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('1학년 1학기 - 덧셈 문제'),
        backgroundColor: Colors.blue,
      ),
      body: _showScore
          ? Center(
              child: FadeTransition(
                opacity: _animation,
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
                                '${question['num1']} + ${question['num2']} = ',
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
