package com.appRenaissance.thisishardcore;

import android.os.Bundle;
import android.app.Activity;
//import android.view.Menu;
import org.apache.cordova.*;

public class MainActivity extends DroidGap {

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        super.setIntegerProperty("splashscreen", R.drawable.splash);
        super.loadUrl("file:///android_asset/www/app.html", 5000);
    }
    
}