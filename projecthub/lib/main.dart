import 'dart:async';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:projecthub/widget/navigation_drawer_widget.dart';
import 'package:projecthub/page/generate_code_page.dart'; // ✅ Import your page
import 'package:projecthub/page/scan_code_page.dart';     // ✅ Import your page

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Project Hub';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: const Color(0xFFF3F4F6),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        home: const AuthPage(),
        routes: {
          "/generate": (context) => const GenerateCodePage(),
          "/scan": (context) => const ScanCodePage(),
        },
      );
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isConnectedToInternet = false;
  StreamSubscription? _internetConnectionStreamSubscription;

  @override
  void initState() {
    super.initState();
    _internetConnectionStreamSubscription =
        InternetConnection().onStatusChange.listen((event) {
      setState(() {
        isConnectedToInternet = event == InternetStatus.connected;
      });
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
        appBar: AppBar(
          title: const Text(
            MyApp.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 4,
        ),
        body: Center(
          child: Card(
            elevation: 8,
            margin: const EdgeInsets.all(24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isConnectedToInternet ? Icons.wifi : Icons.wifi_off,
                    size: 70,
                    color: isConnectedToInternet ? Colors.green : Colors.red,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    isConnectedToInternet
                        ? "Internet Connection Active"
                        : "No Internet Connection",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isConnectedToInternet ? Colors.green : Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isConnectedToInternet
                        ? "You're connected and good to go!"
                        : "Please check your connection settings.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _authenticated = false;

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  Future<void> _authenticate() async {
    bool authenticated = false;

    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to access the app',
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      debugPrint('Auth error: $e');
    }

    if (!mounted) return;

    setState(() => _authenticated = authenticated);
  }

  @override
  Widget build(BuildContext context) {
    return _authenticated
        ? const MainPage()
        : const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
  }
}
