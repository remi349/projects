package com.example.lighttourismfinal;

import android.Manifest;
import android.app.Activity;
import android.content.Context;
import android.location.LocationManager;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;

/**
 * class which was used only to test the app
 */
public class ItineraryActivity extends AppCompatActivity {

    private static final int REQUEST_LOCATION = 1;
    Button btnGetLocation;
    TextView showLocation;
    Context c = this;
    Activity a = this;
    
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_itinerary);
        ActivityCompat.requestPermissions( this,
                new String[] {Manifest.permission.ACCESS_FINE_LOCATION}, REQUEST_LOCATION);
        showLocation = findViewById(R.id.showLocation);
        btnGetLocation = findViewById(R.id.btnGetLocation);
        btnGetLocation.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                MySingleton.getInstance(c).setLocationManager((LocationManager) getSystemService(Context.LOCATION_SERVICE));
                if (!MySingleton.getInstance(c).getLocationManager().isProviderEnabled(LocationManager.GPS_PROVIDER)) {
                    MySingleton.getInstance(c).OnGPS(c);
                } else {
                    String latitude = MySingleton.getInstance(c).getLocation(c,a)[0];
                    String longitude = MySingleton.getInstance(c).getLocation(c,a)[1];
                    showLocation.setText("Your Location: " + "\n" + "Latitude: " + latitude + "\n" + "Longitude: " + longitude);
                }
            }
        });
    }
}