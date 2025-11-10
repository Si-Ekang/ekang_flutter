package com.siekang.ekang_flutter

import android.app.Application
import android.util.Log
import com.google.android.gms.ads.MobileAds
import com.google.android.gms.ads.initialization.InitializationStatus
import com.google.firebase.FirebaseApp
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch


class SiEkangApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        initFirebase()
        initMobileAds()

        Log.d(
            SiEkangApplication::class.java.simpleName,
            "onCreate() | ${SiEkangApplication::class.java} app successfully created"
        )
    }

    fun initFirebase() {
        Log.d(SiEkangApplication::class.java.simpleName, "initFirebase()")
        FirebaseApp.initializeApp(this)
    }

    fun initMobileAds() {
        Log.d(SiEkangApplication::class.java.simpleName, "initMobileAds()")
        CoroutineScope(Dispatchers.IO).launch {
            // Initialize the Google Mobile Ads SDK on a background thread.
            MobileAds.initialize(this@MainActivity) { initializationStatus: InitializationStatus -> }
        }
    }
}