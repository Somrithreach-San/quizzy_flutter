// ignore_for_file: use_super_parameters, prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/provider/provider.dart';

class BackgroundThemeScreen extends StatefulWidget {
  const BackgroundThemeScreen({Key? key}) : super(key: key);

  @override
  _BackgroundThemeScreenState createState() => _BackgroundThemeScreenState();
}

class _BackgroundThemeScreenState extends State<BackgroundThemeScreen> {
  late int _selectedIndex;

  List<String> backgroundImages = [
    'Assets/images/bg0.jpg',
    'Assets/images/bg1.jpg',
    'Assets/images/bg2.jpg',
    'Assets/images/bg3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex =
        Provider.of<UiProvider>(context, listen: false).selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Provider.of<UiProvider>(context).isDark;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(backgroundImages[_selectedIndex]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
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
                  SizedBox(width: 30),
                  Text(
                    'Background Theme',
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
          Positioned(
            top: 120,
            left: 16,
            right: 16,
            bottom: 16,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: backgroundImages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                      Provider.of<UiProvider>(context, listen: false)
                          .setSelectedIndex(index);
                    });
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: backgroundImages[_selectedIndex] ==
                              backgroundImages[index]
                          ? BorderSide(color: Colors.green, width: 5.0)
                          : BorderSide.none,
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
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: AssetImage(backgroundImages[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        if (backgroundImages[_selectedIndex] ==
                            backgroundImages[index])
                          Positioned(
                            bottom: 8.0,
                            left: 8.0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              color: Colors.black54,
                              child: Text(
                                'Current',
                                style: GoogleFonts.ubuntu(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
