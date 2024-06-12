// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable, use_key_in_widget_constructors, non_constant_identifier_names, sized_box_for_whitespace, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/provider/provider.dart';
import 'package:quizzy/screens/home_screen.dart';
import 'package:quizzy/screens/result_screen.dart';
import 'package:quizzy/services/database.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';

class QuestionScreen extends StatefulWidget {
  String category;
  int totalQuestions;
  bool resultScreenShown = false;
  QuestionScreen({required this.category, required this.totalQuestions});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  bool show = false;
  int score = 0;

  int selectedOption = -1;
  bool isCorrect = false;

  late Timer _timer;
  int _seconds = 50;
  bool _isAnswered = false;

  void _startTimer() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        setState(() {
          if (_seconds > 0) {
            _seconds--;
          } else {
            timer.cancel();
            if (!_isAnswered) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultScreen(
                    score: score,
                    totalQuestions: widget.totalQuestions,
                    timerCompleted: true,
                    category: widget.category,
                  ),
                ),
              );
            }
          }
        });
      },
    );
  }

  @override
  void initState() {
    getontheload();
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  getontheload() async {
    QuizStream = await DatabaseMethods().getCategoryQuiz(widget.category);
    setState(() {});
  }

  int currentIndex = 0;

  Stream? QuizStream;
  PageController controller = PageController();

  Widget allQuiz() {
    final bool isDarkMode = Provider.of<UiProvider>(context).isDark;

    return StreamBuilder(
      stream: QuizStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final List<DocumentSnapshot> docs = snapshot.data.docs;
          return PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: controller,
            itemBuilder: (context, index) {
              currentIndex = index;
              DocumentSnapshot ds = docs[index];
              return Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Provider.of<UiProvider>(context)
                            .darkTheme
                            .colorScheme
                            .primary
                        : Provider.of<UiProvider>(context)
                            .lightTheme
                            .colorScheme
                            .primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: CachedNetworkImage(
                            imageUrl: ds["Image"],
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      GestureDetector(
                        onTap: () {
                          if (!show) {
                            selectedOption = 1;
                            isCorrect = ds["correct"] == ds["option1"];
                            score += isCorrect ? 1 : 0;
                            show = true;
                            setState(() {});
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          decoration: BoxDecoration(
                              color: show && ds["correct"] == ds["option1"]
                                  ? Colors.green
                                  : (show && selectedOption == 1
                                      ? Colors.red
                                      : Colors.transparent),
                              border: Border.all(
                                  color: Color(0xFF818181), width: 1.5),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ds["option1"],
                                style: GoogleFonts.ubuntu(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                              if (show)
                                Icon(
                                  ds["correct"] == ds["option1"]
                                      ? Icons.check
                                      : (selectedOption == 1
                                          ? Icons.close
                                          : null),
                                  color: ds["correct"] == ds["option1"]
                                      ? Colors.white
                                      : (selectedOption == 1
                                          ? Colors.white
                                          : Colors.transparent),
                                ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      GestureDetector(
                        onTap: () {
                          if (!show) {
                            selectedOption = 2;
                            isCorrect = ds["correct"] == ds["option2"];
                            score += isCorrect ? 1 : 0;
                            show = true;
                            setState(() {});
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          decoration: BoxDecoration(
                              color: show && ds["correct"] == ds["option2"]
                                  ? Colors.green
                                  : (show && selectedOption == 2
                                      ? Colors.red
                                      : Colors.transparent),
                              border: Border.all(
                                  color: Color(0xFF818181), width: 1.5),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ds["option2"],
                                style: GoogleFonts.ubuntu(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                              if (show)
                                Icon(
                                  ds["correct"] == ds["option2"]
                                      ? Icons.check
                                      : (selectedOption == 2
                                          ? Icons.close
                                          : null),
                                  color: ds["correct"] == ds["option2"]
                                      ? Colors.white
                                      : (selectedOption == 2
                                          ? Colors.white
                                          : Colors.transparent),
                                ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      GestureDetector(
                        onTap: () {
                          if (!show) {
                            selectedOption = 3;
                            isCorrect = ds["correct"] == ds["option3"];
                            score += isCorrect ? 1 : 0;
                            show = true;
                            setState(() {});
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          decoration: BoxDecoration(
                              color: show && ds["correct"] == ds["option3"]
                                  ? Colors.green
                                  : (show && selectedOption == 3
                                      ? Colors.red
                                      : Colors.transparent),
                              border: Border.all(
                                  color: Color(0xFF818181), width: 1.5),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ds["option3"],
                                style: GoogleFonts.ubuntu(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                              if (show)
                                Icon(
                                  ds["correct"] == ds["option3"]
                                      ? Icons.check
                                      : (selectedOption == 3
                                          ? Icons.close
                                          : null),
                                  color: ds["correct"] == ds["option3"]
                                      ? Colors.white
                                      : (selectedOption == 3
                                          ? Colors.white
                                          : Colors.transparent),
                                ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      GestureDetector(
                        onTap: () {
                          if (!show) {
                            selectedOption = 4;
                            isCorrect = ds["correct"] == ds["option4"];
                            score += isCorrect ? 1 : 0;
                            show = true;
                            setState(() {});
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          decoration: BoxDecoration(
                              color: show && ds["correct"] == ds["option4"]
                                  ? Colors.green
                                  : (show && selectedOption == 4
                                      ? Colors.red
                                      : Colors.transparent),
                              border: Border.all(
                                  color: Color(0xFF818181), width: 1.5),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ds["option4"],
                                style: GoogleFonts.ubuntu(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                              if (show)
                                Icon(
                                  ds["correct"] == ds["option4"]
                                      ? Icons.check
                                      : (selectedOption == 4
                                          ? Icons.close
                                          : null),
                                  color: ds["correct"] == ds["option4"]
                                      ? Colors.white
                                      : (selectedOption == 4
                                          ? Colors.white
                                          : Colors.transparent),
                                ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      GestureDetector(
                        onTap: selectedOption != -1
                            ? () {
                                setState(() {
                                  show = false;
                                  selectedOption = -1;
                                  if (index == docs.length - 1) {
                                    navigateToResultScreen(score);
                                  } else {
                                    controller.nextPage(
                                      duration: Duration(milliseconds: 200),
                                      curve: Curves.easeIn,
                                    );
                                  }
                                });
                              }
                            : null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedOption != -1
                                      ? (isDarkMode
                                          ? Colors.white
                                          : Colors.black)
                                      : Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(60),
                              ),
                              child: index == docs.length - 1
                                  ? Image.asset(
                                      'Assets/images/icons8-check-24.png',
                                      color: selectedOption != -1
                                          ? (isDarkMode
                                              ? Colors.white
                                              : Colors.black)
                                          : Colors.grey,
                                      width: 24,
                                      height: 24,
                                    )
                                  : Image.asset(
                                      'Assets/images/icons8-forward-24.png',
                                      color: selectedOption != -1
                                          ? (isDarkMode
                                              ? Colors.white
                                              : Colors.black)
                                          : Colors.grey,
                                      width: 24,
                                      height: 24,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: docs.length,
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = Provider.of<UiProvider>(context).selectedIndex;
    String backgroundImage = 'Assets/images/bg$selectedIndex.jpg';
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(backgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40.0, left: 15.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          },
                          child: Image.asset(
                            'Assets/images/icons8-back-24.png',
                            color: Colors.white,
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Expanded(
                        child: Text(
                          widget.category,
                          style: GoogleFonts.ubuntu(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: .0),
                      Text(
                        '$_seconds',
                        style: GoogleFonts.ubuntu(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Expanded(child: allQuiz()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void navigateToResultScreen(int score) {
    if (!widget.resultScreenShown) {
      widget.resultScreenShown = true;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            score: score,
            totalQuestions: widget.totalQuestions,
            timerCompleted: false,
            category: widget.category,
          ),
        ),
      ).then((_) {
        widget.resultScreenShown = false;
      });
    }
  }
}
