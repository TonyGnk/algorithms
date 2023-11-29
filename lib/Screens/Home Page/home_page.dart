import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Services & Providers/welcome_dialog.dart';
import '../../UI/Adaptive Templates/body_with_appbar.dart';
import '../../UI/Routed Screen/app_bar.dart';
import 'modern_button.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build2(BuildContext context) => bodyWithAppBar(
        context: context,
        appBar: appBarBf(context),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Body(),
        ),
      );

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: Future.delayed(const Duration(milliseconds: 1)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return bodyWithAppBarGlass(
              context: context,
              appBar: appBarBf(context),
              body: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Body(),
              ),
            ); // Render the widget with blur effect
          } else {
            return bodyWithAppBar(
              context: context,
              appBar: appBarBf(context),
              body: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Body(),
              ),
            ); // Render the widget without blur effect
          }
        },
      );
}

// Αυτή είναι η γραμμή τίτλου της οθόνης
// Περιλαμβάνει το όνομα του αλγορίθμου και τα εικονίδια θέματος και πληροφοριών
Widget appBarBf(BuildContext context) => AdaptAppBar(
      filled: false,
      label: '',
      showThemeIcon: true,
      showBackButton: false,
      brightness: Theme.of(context).brightness,
      backgroundColor: Colors.transparent,
    );

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    // unawaited(checkFirstRun().catchError((error) {
    //   // Handle any errors here.
    //   log('An error occurred: $error');
    // }));
  }

  Future<void> checkFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstRun = prefs.getBool('firstRun') ?? true;
    if (isFirstRun) {
      Future.delayed(Duration.zero, () {
        showAlert(context, false);
      });
      await prefs.setBool('firstRun', false);
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(
            color:
                Colors.transparent //Theme.of(context).scaffoldBackgroundColor,
            ),
        child: const Row(
          children: [
            Expanded(
              flex: 3,
              child: SizedBox(),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: SizedBox()),
                  Text(
                    'Welcome to',
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'AdventoPro',
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Algorithms Visualizer',
                    style: TextStyle(
                        fontSize: 32,
                        color: Color.fromRGBO(32, 102, 224, 0.9),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  Expanded(flex: 3, child: SizedBox()),
                  Text('Select the mode you want to use:'),
                  SizedBox(height: 16),
                  Row(children: [
                    TheGloriousButton(
                      label: 'Terminal',
                      icon: Icons.terminal,
                    ),
                    SizedBox(width: 10),
                    TheGloriousButton(
                        label: 'GUI', icon: Icons.desktop_windows_outlined),
                  ]),
                  Expanded(flex: 1, child: SizedBox()),
                ],
              ),
            ),
          ],
        ),
      );
}

//terminalSide(context)
//ButtonsSide
