import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:projecthub/widget/button_widget.dart';
import 'package:projecthub/widget/navigation_drawer_widget.dart';

Future main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Navigation Drawer';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MainPage(),
      );
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isConnectedToInternet = false;

  StreamSubscription ? _internetConnectionStreamSubscription;

  @override
  void initState(){
    super.initState();
    _internetConnectionStreamSubscription = InternetConnection().onStatusChange.listen((event){ 
      switch (event) {
        case InternetStatus.connected:
         setState(() {
          isConnectedToInternet = true;
        });
          break;
          case InternetStatus.disconnected:
           setState(() {
          isConnectedToInternet = false;
        });
          break;
        default:
        setState(() {
          isConnectedToInternet = false;
        });
        break;
      }
    });
  }

  @override
  void dispose() {
    _internetConnectionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavigationDrawerWidget(),
        // endDrawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text(MyApp.title),
        ),
        body: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(isConnectedToInternet ? Icons.wifi : Icons.wifi_off,
              size: 50,
              color: isConnectedToInternet ? Colors.green : Colors.red,)
            ],
          ),
        )
      );
}