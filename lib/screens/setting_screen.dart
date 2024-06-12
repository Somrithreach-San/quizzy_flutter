// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_super_parameters
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/admin/admin_login_screen.dart';
import 'package:quizzy/provider/provider.dart';
import 'package:quizzy/screens/background_theme.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final List<String> settingTitles = [
    'Dark Mode',
    'Background Theme',
    'Admin Panel',
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Provider.of<UiProvider>(context).isDark;
    final int selectedIndex = Provider.of<UiProvider>(context).selectedIndex;

    String backgroundImage = 'Assets/images/bg$selectedIndex.jpg';

    void navigateToBackgroundThemeScreen() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BackgroundThemeScreen()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(backgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.only(top: 50.0, left: 20.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                        ),
                        padding: EdgeInsets.all(8.0),
                        child: Image.asset(
                          'Assets/images/icons8-back-24.png',
                          color: Colors.white,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 100.0),
                  Text(
                    'Settings',
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
          ),
          Container(
            margin: EdgeInsets.only(top: 120.0),
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              itemCount: settingTitles.length,
              itemBuilder: (context, index) {
                final settingTitle = settingTitles[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 4.0,
                  color: isDarkMode
                      ? Provider.of<UiProvider>(context)
                          .darkTheme
                          .colorScheme
                          .primary
                      : Provider.of<UiProvider>(context)
                          .lightTheme
                          .colorScheme
                          .primary,
                  child: ListTile(
                    title: Text(
                      settingTitle,
                      style: GoogleFonts.ubuntu(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        color: Provider.of<UiProvider>(context).isDark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    trailing: settingTitle == 'Dark Mode'
                        ? Switch(
                            activeColor: Colors.white,
                            value: Provider.of<UiProvider>(context).isDark,
                            onChanged: (value) =>
                                context.read<UiProvider>().changeTheme(),
                          )
                        : settingTitle == 'Background Theme'
                            ? Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: GestureDetector(
                                  onTap: navigateToBackgroundThemeScreen,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.transparent,
                                    ),
                                    padding: EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'Assets/images/icons8-forward-24.png',
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                ),
                              )
                            : settingTitle == 'Admin Panel'
                                ? Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AdminLoginScreen(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.transparent,
                                        ),
                                        padding: EdgeInsets.all(
                                            8.0), // Adjust padding as needed
                                        child: Image.asset(
                                          'Assets/images/icons8-forward-24.png',
                                          color: isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                    ),
                                  )
                                : null,
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Developed by @San Somrithreach',
                    style: GoogleFonts.ubuntu(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Version 1.0.0',
                    style: GoogleFonts.ubuntu(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
