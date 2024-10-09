package com.example.lighttourismfinal;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;

public class SignUpActivity extends AppCompatActivity {

    private String username = "...";
    private String password = "...";
    private String email = "...";

    private EditText eemail;
    private EditText eusername;
    private EditText epassword;
    private EditText econfirmPassword;
    private Button subscribeBtn;

    private boolean uniqueness = false;

    SharedPreferences sharedPreferences;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sign_up);


        eemail = (EditText) findViewById(R.id.email);
        eusername = (EditText) findViewById(R.id.username);
        epassword = (EditText) findViewById(R.id.password);
        econfirmPassword = (EditText) findViewById(R.id.confirm_password);
        subscribeBtn = (Button) findViewById(R.id.subscribe_btn);

        eemail.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });

        eusername.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });

        epassword.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });

        econfirmPassword.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });

        subscribeBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // The user just clicked
                username = eusername.getText().toString();
                password = epassword.getText().toString();
                email = eemail.getText().toString();

                requestStringToCheckEmailUniqueness("http://137.194.210.201/profilExistence/" + email);

            }
        });
    }


    public void requestStringToCheckEmailUniqueness(String url) {
        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                new Response.Listener<String>() {
                    @Override
                    //Action to perform with the response of the http request
                    public void onResponse(String response) {
                        //response is false if a user using this email already has existed

                        if (response.equals("True")){
                            CharSequence text = "Invalid email. Another account already use this email";
                            int duration = Toast.LENGTH_SHORT;

                            Toast toast = Toast.makeText(getApplicationContext(), text, duration);
                            toast.show();
                        }

                        else if (response.equals("False")){
                            if (!(econfirmPassword.getText().toString().equals(password))){
                                CharSequence text = "The two passwords aren't the same. Please make them match.";
                                int duration = Toast.LENGTH_SHORT;

                                Toast toast = Toast.makeText(getApplicationContext(), text, duration);
                                toast.show();
                            }

                            else if(password.length() == 0){
                                CharSequence text = "Invalid password";
                                int duration = Toast.LENGTH_SHORT;

                                Toast toast = Toast.makeText(getApplicationContext(), text, duration);
                                toast.show();
                            }

                            else if(!(android.util.Patterns.EMAIL_ADDRESS.matcher(email).matches())){
                                CharSequence text = "Invalid email";
                                int duration = Toast.LENGTH_SHORT;

                                Toast toast = Toast.makeText(getApplicationContext(), text, duration);
                                toast.show();
                            }

                            else {
                                // to share values with ProfileActivity
                                Intent i = new Intent(getApplicationContext(), ProfileActivity.class);

                                /********* Créer un fichier contenant les infos de l'utilisateur --> remplace une class user *********/

                                sharedPreferences = getSharedPreferences("profile", Context.MODE_PRIVATE);

                                SharedPreferences.Editor editor = sharedPreferences.edit();

                                editor.putString("USERNAME", username);
                                editor.putString("EMAIL", email);
                                editor.putString("PASSWORD", password);
                                // Factors
                                editor.putInt("POPULARITYFACTOR",1);
                                editor.putInt("METEOFACTOR",1);
                                editor.putInt("TEMPERATUREFACTOR",1);
                                editor.putInt("LOCALISATIONFACTOR",1);
                                editor.putInt("AFFLUENCEFACTOR",1);
                                editor.putInt("PRICEFACTOR",1);

                                editor.apply();

                                requestStringToCreateProfile("http://137.194.210.201/profilCreation/" + username + "/" + email + "/" + password + "/1/1/1/1/1/1");

                                startActivity(i);
                                finish();
                            }
                        }
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


    public void requestStringToCreateProfile(String url) {
        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                new Response.Listener<String>() {
                    @Override
                    //Action to perform with the response of the http request
                    public void onResponse(String response) {

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