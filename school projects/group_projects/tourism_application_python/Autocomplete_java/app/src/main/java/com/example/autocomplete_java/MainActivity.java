package com.example.autocomplete_java;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;
import com.google.android.libraries.places.api.Places;
import com.google.android.libraries.places.api.model.Place;
import com.google.android.libraries.places.api.net.PlacesClient;
import com.google.android.libraries.places.widget.Autocomplete;
import com.google.android.libraries.places.widget.model.AutocompleteActivityMode;

import java.util.Arrays;
import java.util.List;


public class MainActivity extends AppCompatActivity implements OnMapReadyCallback {

    private String apiKey="AIzaSyATLwi1Cm_OT9klk8061h2FKgCeRQG-nVo";
    private static int AUTOCOMPLETE_REQUEST_CODE = 1;
    List<Place.Field> fields;

    private TextView placeSearch_TV;
    String latitude="", longitude="";
    private GoogleMap mMap;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        placeSearch_TV=findViewById(R.id.placeSearch_TV);

        if(!Places.isInitialized()){
            Places.initialize(getApplicationContext(),apiKey);
        }

        // Create a new PlacesClient instance
        PlacesClient placesClient = Places.createClient(this);

        // Set the fields to specify which types of place data to
        // return after the user has made a selection.
        fields = Arrays.asList(Place.Field.ID, Place.Field.NAME);


        placeSearch_TV.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View V){
                Intent intent = new Autocomplete.IntentBuilder(AutocompleteActivityMode.FULLSCREEN, fields)
                        .build(MainActivity.this);
                startActivityForResult(intent, AUTOCOMPLETE_REQUEST_CODE);
            }

        });

        SupportMapFragment mapFragment = (SupportMapFragment) getSupportFragmentManager()
                .findFragmentById(R.id.map);
        mapFragment.getMapAsync(this);

    }




    public void onMapReady(GoogleMap googleMap) {

        mMap=googleMap;
        LatLng sydney = new LatLng(48.856614, 2.3522219);
        googleMap.addMarker(new MarkerOptions()
                .position(sydney)
                .title("Marker in Paris"));
    }
}