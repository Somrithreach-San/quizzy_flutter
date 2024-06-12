// ignore_for_file: sort_child_properties_last, use_key_in_widget_constructors, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/provider/provider.dart';
import 'package:quizzy/screens/home_screen.dart';
import 'package:quizzy/screens/question.screen.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final bool timerCompleted;
  final String category;

  const ResultScreen({
    required this.score,
    required this.totalQuestions,
    required this.timerCompleted,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final isDarkMode = uiProvider.isDark;
    final theme = isDarkMode ? uiProvider.darkTheme : uiProvider.lightTheme;

    List<String> resultImages = [
      "Assets/images/congratulation.png",
      "Assets/images/clock.png",
      "Assets/images/never-give-up.png",
    ];

    int imageIndex;
    if (timerCompleted) {
      imageIndex = 1;
    } else if (score > 0) {
      imageIndex = 0;
    } else {
      imageIndex = 2;
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        centerTitle: true,
        title: Text(
          "Result",
          style: GoogleFonts.ubuntu(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Material(
              elevation: 10.0,
              child: Container(
                color: theme.colorScheme.background,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Material(
                      child: Container(
                        width: 200.0,
                        height: 200.0,
                        child: ClipRect(
                          child: Container(
                            color: theme.colorScheme.background,
                            child: Image.asset(
                              resultImages[imageIndex],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Center(
                      child: Text(
                        "You scored $score / $totalQuestions",
                        style: GoogleFonts.ubuntu(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuestionScreen(
                                category: category,
                                totalQuestions: totalQuestions,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "Play Again",
                          style: GoogleFonts.ubuntu(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          minimumSize: const Size(150, 50),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 25.0,
                          ),
                          backgroundColor:
                              isDarkMode ? Colors.black : Colors.white,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Finish",
                          style: GoogleFonts.ubuntu(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          minimumSize: const Size(150, 50),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 25.0,
                          ),
                          backgroundColor:
                              isDarkMode ? Colors.black : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
