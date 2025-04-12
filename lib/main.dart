import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'services/environment_service.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Chargement des variables d'environnement
  final envService = EnvironmentService();
  await envService.loadEnv();
  
  // Initialisation de Firebase
  if (envService.env['MODE'] != 'demo') {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: envService.isAndroid 
          ? envService.env['FIREBASE_API_KEY_ANDROID'] 
          : envService.env['FIREBASE_API_KEY_IOS'],
        appId: envService.env['FIREBASE_APP_ID'],
        messagingSenderId: envService.env['FIREBASE_MESSAGING_SENDER_ID'],
        projectId: envService.env['FIREBASE_PROJECT_ID'],
        storageBucket: envService.env['FIREBASE_STORAGE_BUCKET'],
      ),
    );
  }
  
  final logger = Logger(
    level: envService.logLevel,
    printer: PrettyPrinter(),
  );
  
  logger.i('Application démarrée en mode: ${envService.env['MODE']}');
  
  runApp(
    MultiProvider(
      providers: [
        Provider<EnvironmentService>.value(value: envService),
        Provider<Logger>.value(value: logger),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final envService = Provider.of<EnvironmentService>(context);
    
    return MaterialApp(
      title: 'PI Mobile App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: envService.env['ENV'] == 'dev',
    );
  }
}
