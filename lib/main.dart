import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mychatapp/controller/auth_service.dart';
import 'package:mychatapp/controller/chat_service.dart';
import 'package:mychatapp/controller/notification_service.dart';
import 'package:mychatapp/firebase_options.dart';
import 'package:mychatapp/screens/chat_screen.dart';
import 'package:mychatapp/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put(AuthService());
  Get.put(ChatService());
  Get.put(NotificationService());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => MyHomePage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/signup', page: () => SignUpPage()),
        GetPage(name: '/chat', page: () => ChatPage()),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthService authService = Get.find();
  
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (authService.user != null) {
        return ChatPage();
      } else {
        return LoginPage();
      }
    });
  }
}
