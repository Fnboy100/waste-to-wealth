package com.example.main

import android.Manifest
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat

class MainActivity : FlutterActivity() {

    private val requestCodePostNotifications = 1

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Check if the device is running Android 13 or higher
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            // Check if the POST_NOTIFICATIONS permission is granted
            if (ContextCompat.checkSelfPermission(this, Manifest.permission.POST_NOTIFICATIONS) 
                != PackageManager.PERMISSION_GRANTED) {
                ActivityCompat.requestPermissions(this, 
                    arrayOf(Manifest.permission.POST_NOTIFICATIONS), 
                    requestCodePostNotifications)
            } else {
                // Permission already granted, proceed with posting notifications
            }
        } else {
            // Android version is lower than 13, no need to request POST_NOTIFICATIONS
            // Proceed with posting notifications
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, 
                                            grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == requestCodePostNotifications) {
            if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                Toast.makeText(this, "Notification permission granted", Toast.LENGTH_SHORT).show()
                // Permission granted, proceed with posting notifications
            } else {
                Toast.makeText(this, "Notification permission denied", Toast.LENGTH_SHORT).show()
                // Permission denied, handle as needed
            }
        }
    }
}
