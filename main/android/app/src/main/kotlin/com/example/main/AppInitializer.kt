package com.example.main

import android.app.Application
import com.google.firebase.FirebaseApp

class AppInitializer : Application() {
    
    override fun onCreate() {
        super.onCreate()
        FirebaseApp.initializeApp(this)
        // Other initialization code for Google Maps, etc.
    }
}

