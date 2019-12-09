import 'package:flutter/material.dart';

import 'package:diletta_bottom_navigator/dilettaBottomNavigator.dart';

import 'painter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  GlobalKey bottomNavigationKey = GlobalKey();

  int currentPage = 0;

  double heightPercentage;
  double widthPercentage;

  @override
  void initState() {

    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    heightPercentage = MediaQuery.of(context).size.height / 667.0;
    widthPercentage = MediaQuery.of(context).size.width / 375.0;
    
    return Scaffold(

      appBar: AppBar(
        
        title: Text('Diletta Bottom Navigator'),
      ),
      body: Center(

        child: _getPage(),
      ),
      bottomNavigationBar: DilettaBottomNavigator(

        tabs: [

          TabData(

            iconData: Icons.people_outline,
            title: "Profissionais",
            onclick: () {

              if (currentPage != 0) {

                final DilettaBottomNavigatorState fState = bottomNavigationKey.currentState;
                fState.setPage(0);
              }
            }
          ),
          TabData(

            iconData: Icons.event,
            title: "Agenda",
            onclick: () {

              if (currentPage != 1) {

                final DilettaBottomNavigatorState fState = bottomNavigationKey.currentState;
                fState.setPage(1);
              }
            }
          ),
          TabData(

            iconData: Icons.history,
            title: "Histórico",
            onclick: () {

              if (currentPage != 2) {

                final DilettaBottomNavigatorState fState = bottomNavigationKey.currentState;
                fState.setPage(2);
              }
            }
          )
        ],
        widthPercentage: widthPercentage,
        heightPercentage: heightPercentage,
        barBackgroundColor: Color(0xff454F63),
        circleColor: Color(0xffF4B22F),
        textColor: Color(0xff979DA8),
        activeTextColor: Color(0xffF4B22F),
        inactiveIconColor: Color(0xff979DA8),
        initialSelection: 0,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {

          setState(() {

            currentPage = position;
          });
        }
      ),
    );
  }

  Widget _getPage() {

    switch(currentPage) {

      case 0: {

        return Center(

          child: Text('Profissionais'),
        );
      }
      break;

      case 1: {

        return Center(

          child: Text('Agenda'),
        );
      }
      break;

      default: {

        return Center(

          child: Text('Histórico'),
        );
      }
      break;
    }
  }
}
