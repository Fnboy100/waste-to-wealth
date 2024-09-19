import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppInitializer {
  static Future<void> initializeApp() async {

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    FirebaseAuth.instance;
    FirebaseFirestore.instance;

    // Initialize Google Maps settings if needed (optional)
    // This can involve API keys or other map settings if needed
  }
}
