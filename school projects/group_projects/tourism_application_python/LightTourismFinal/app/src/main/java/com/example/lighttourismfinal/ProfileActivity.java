package com.example.lighttourismfinal;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.SeekBar;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;

public class ProfileActivity extends AppCompatActivity {

    private TextView usernameProfileTV;
    private TextView emailProfileTV;

    private Button signUpBtn;
    private Button logInBtn;
    private Button setUpBtn;

    private SeekBar popularitySB;
    private SeekBar weatherSB;
    private SeekBar temperatureSB;
    private SeekBar localisationSB;
    private SeekBar affluenceSB;
    private SeekBar priceSB;

    SharedPreferences sharedPreferences;



    @SuppressLint("SetTextI18n")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_profile);


        Context context = getApplicationContext();
        sharedPreferences =  context.getSharedPreferences("profile", Context.MODE_PRIVATE);

        usernameProfileTV = (TextView) findViewById(R.id.username_profile);
        emailProfileTV = (TextView) findViewById(R.id.email_profile);

        signUpBtn = (Button) findViewById(R.id.signup_btn);
        logInBtn = (Button) findViewById(R.id.login_btn);
        setUpBtn = (Button) findViewById(R.id.editFactors_btn);

        popularitySB = (SeekBar) findViewById(R.id.seekBar_factor1);
        weatherSB = (SeekBar) findViewById(R.id.seekBar_factor2);
        temperatureSB = (SeekBar) findViewById(R.id.seekBar_factor3);
        localisationSB = (SeekBar) findViewById(R.id.seekBar_factor4);
        affluenceSB = (SeekBar) findViewById(R.id.seekBar_factor5);
        priceSB = (SeekBar) findViewById(R.id.seekBar_factor6);

        popularitySB.setMax(250);
        weatherSB.setMax(250);
        temperatureSB.setMax(250);
        localisationSB.setMax(250);
        affluenceSB.setMax(250);
        priceSB.setMax(250);

        popularitySB.setProgress(sharedPreferences.getInt("POPULARITYFACTOR",1));
        weatherSB.setProgress(sharedPreferences.getInt("METEOFACTOR",1));
        temperatureSB.setProgress(sharedPreferences.getInt("TEMPERATUREFACTOR",1));
        localisationSB.setProgress(sharedPreferences.getInt("LOCALISATIONFACTOR",1));
        affluenceSB.setProgress(sharedPreferences.getInt("AFFLUENCEFACTOR",1));
        priceSB.setProgress(sharedPreferences.getInt("PRICEFACTOR",1));


        /**************** Actualize the TextViews **************/

        usernameProfileTV.setText("Username : " + sharedPreferences.getString("USERNAME","t naz"));
        emailProfileTV.setText("Email : " + sharedPreferences.getString("EMAIL","t naz"));



        signUpBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // The user just clicked
                Intent SignUpActivity = new Intent(ProfileActivity.this, SignUpActivity.class);
                startActivity(SignUpActivity);
                finish();
            }
        });


        logInBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // The user just clicked
                Intent LogInActivity = new Intent(ProfileActivity.this, LogInActivity.class);
                startActivity(LogInActivity);
                finish();
            }
        });

        setUpBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // The user just clicked
                SharedPreferences.Editor editor = sharedPreferences.edit();

                // Factors
                editor.putInt("POPULARITYFACTOR",popularitySB.getProgress());
                editor.putInt("METEOFACTOR",weatherSB.getProgress());
                editor.putInt("TEMPERATUREFACTOR",temperatureSB.getProgress());
                editor.putInt("LOCALISATIONFACTOR",localisationSB.getProgress());
                editor.putInt("AFFLUENCEFACTOR",affluenceSB.getProgress());
                editor.putInt("PRICEFACTOR",priceSB.getProgress());

                editor.apply();

                requestStringToEditFactor("http://137.194.210.201/profilEdition/" + sharedPreferences.getString("USERNAME","t naz") + "/" + sharedPreferences.getInt("POPULARITYFACTOR",-1) + "/" + sharedPreferences.getInt("METEOFACTOR",-1) + "/" + sharedPreferences.getInt("TEMPERATUREFACTOR",-1) + "/" + sharedPreferences.getInt("LOCALISATIONFACTOR",-1) + "/" + sharedPreferences.getInt("AFFLUENCEFACTOR",-1) + "/" + sharedPreferences.getInt("PRICEFACTOR",-1));
            }
        });

    }


    public void requestStringToEditFactor(String url) {
        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                new Response.Listener<String>() {
                    @Override
                    //Action to perform with the response of the http request
                    public void onResponse(String response) {
                        CharSequence text = "Factors have been set up successfully !";
                        int duration = Toast.LENGTH_SHORT;

                        Toast toast = Toast.makeText(getApplicationContext(), text, duration);
                        toast.show();
                    }
                },
                new Response.ErrorListener() {
                    @SuppressLint("SetTextI18n")
                    @Override
                    //Action to perform in case http request fail
                    public void onErrorResponse(VolleyError error) {
                        CharSequence text = "Error";
                        int duration = Toast.LENGTH_SHORT;

                        Toast toast = Toast.makeText(getApplicationContext(), text, duration);
                        toast.show();
                    }
                });

        // Add a request (in this example, called stringRequest) to your RequestQueue.
        MySingleton.getInstance(this).addToRequestQueue(stringRequest);
    }
}