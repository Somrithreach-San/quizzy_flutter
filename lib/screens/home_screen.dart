// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/provider/provider.dart';
import 'package:quizzy/screens/question.screen.dart';
import 'package:quizzy/screens/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Provider.of<UiProvider>(context).isDark;
    final int selectedIndex = Provider.of<UiProvider>(context).selectedIndex;
    String backgroundImage = 'Assets/images/bg$selectedIndex.jpg';

    return Scaffold(
      backgroundColor: isDarkMode
          ? Provider.of<UiProvider>(context).darkTheme.colorScheme.background
          : Provider.of<UiProvider>(context).lightTheme.colorScheme.background,
      body: Container(
        child: Column(
          children: [
            Container(
              height: 200,
              padding: EdgeInsets.only(left: 20.0, top: 50.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                image: DecorationImage(
                  image: AssetImage(backgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "Assets/images/quiz.png",
                    height: 90,
                    width: 90,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 30.0),
                        child: Row(
                          children: [
                            Text(
                              "Quiz Time!",
                              style: GoogleFonts.ubuntu(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Image.asset(
                              'Assets/images/idea.png',
                              width: 30,
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 5.0,
                        ),
                        child: Text(
                          "Play Quiz by guessing the image",
                          style: GoogleFonts.ubuntu(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              color: Colors.grey[300]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    child: Center(
                      child: Text(
                        "         Quiz Categories",
                        style: GoogleFonts.ubuntu(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: isDarkMode ? Colors.white : Colors.black,
                    size: 30.0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingScreen()),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionScreen(
                                    category: "Places",
                                    totalQuestions: 5,
                                  )));
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 5.0,
                      child: Container(
                        width: 150,
                        padding: EdgeInsets.all(10.0),
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
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Image.asset(
                              "Assets/images/places.png",
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              "Places",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionScreen(
                                    category: "Animals",
                                    totalQuestions: 5,
                                  )));
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 5.0,
                      child: Container(
                        width: 150,
                        padding: EdgeInsets.all(10.0),
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
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Image.asset(
                              "Assets/images/animal.png",
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              "Animals",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionScreen(
                            category: "Fruits",
                            totalQuestions: 5,
                          ),
                        ),
                      );
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 5.0,
                      child: Container(
                        width: 150,
                        padding: EdgeInsets.all(10.0),
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
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              "Assets/images/fruit.png",
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              "Fruits",
                              style: GoogleFonts.ubuntu(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionScreen(
                                    category: "Countries",
                                    totalQuestions: 5,
                                  )));
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 5.0,
                      child: Container(
                        width: 150,
                        padding: EdgeInsets.all(10.0),
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
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Image.asset(
                              "Assets/images/country.png",
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              "Countries",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionScreen(
                                    category: "Random",
                                    totalQuestions: 5,
                                  )));
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 5.0,
                      child: Container(
                        width: 150,
                        padding: EdgeInsets.all(10.0),
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
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Image.asset(
                              "Assets/images/random.png",
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              "Random",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionScreen(
                                    category: "Sports",
                                    totalQuestions: 5,
                                  )));
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 5.0,
                      child: Container(
                        width: 150,
                        padding: EdgeInsets.all(10.0),
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
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Image.asset(
                              "Assets/images/sport.png",
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              "Sports",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
