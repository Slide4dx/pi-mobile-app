import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class EnvironmentService {
  Map<String, dynamic> env = {};
  bool get isAndroid => Platform.isAndroid;
  
  // Niveau de log par défaut
  Level get logLevel {
    switch(env['LOG_LEVEL']?.toLowerCase()) {
      case 'verbose': return Level.verbose;
      case 'debug': return Level.debug;
      case 'info': return Level.info;
      case 'warning': return Level.warning;
      case 'error': return Level.error;
      case 'wtf': return Level.wtf;
      case 'nothing': return Level.nothing;
      default: return Level.info;
    }
  }
  
  // Chargement des variables d'environnement depuis le fichier env.json
  Future<void> loadEnv() async {
    try {
      final String envFile = await rootBundle.loadString('env.json');
      env = json.decode(envFile);
    } catch (e) {
      print('Erreur lors du chargement des variables d\'environnement: $e');
      // Valeurs par défaut en cas d'erreur
      env = {
        "ENV": "dev",
        "MODE": "demo",
        "LOG_LEVEL": "info",
        "API_URL": "https://xyz.com",
        "VERSION": "0.0.1"
      };
    }
  }
  
  // Vérifie si l'application est en mode démo
  bool get isDemo => env['MODE'] == 'demo';
  
  // Vérifie si l'application est en environnement de développement
  bool get isDev => env['ENV'] == 'dev';
}
