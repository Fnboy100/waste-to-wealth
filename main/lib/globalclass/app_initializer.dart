import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main/config/storeage/api_config_keys.dart';
import 'package:main/config/storeage/api_key_type.dart';
import 'package:main/config/storeage/secure_storage_service.dart';
import 'package:main/globalclass/location_app_initializer.dart';

class AppInitializer {
  static Future<void>
      initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _initializeFirebase();
    await _storeApiKey();
    LocationAppInitializer
        locationAppInitializer =
        LocationAppInitializer();
        await locationAppInitializer.initializeApp();
    
    

    // non-critical initializations here
    // without blocking the main UI.
    _performNonEssentialInitialization();
    
  }

  static Future<void>
      _initializeFirebase() async {
    await Firebase.initializeApp();
    FirebaseAuth.instance;
    FirebaseFirestore.instance;
  }

  static Future<void>
      _storeApiKey() async {
    await SecureStorageService.storeApiKey(ApiKeyType.wasteManagementKey,
        ApiKeyConstants.wasteManagementKey);
    await SecureStorageService.storeApiKey(ApiKeyType.googleApiKey,
        ApiKeyConstants.googlAapiKey);
  }

  // Non-essential initializations can be done after the app is responsive
  static void
      _performNonEssentialInitialization() {
    // fetch user settings or pre-cache assets
  }
}
