package com.example.lighttourismfinal;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.example.lighttourismfinal.databinding.ActivityLogInBinding;

public class LogInActivity extends AppCompatActivity {

    private EditText eemail;
    private EditText epassword;
    private Button loginBtn;

    private ActivityLogInBinding binding;

    SharedPreferences sharedPreferences;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        binding = ActivityLogInBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        Context context =getApplicationContext();
        sharedPreferences =  context.getSharedPreferences("profile", Context.MODE_PRIVATE);

        eemail = (EditText) findViewById(R.id.email_login);
        epassword = (EditText) findViewById(R.id.password_login);
        loginBtn = (Button) findViewById(R.id.loglogin_btn);

        loginBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // The user just clicked
                requestStringToCheckProfile("http://137.194.210.201/profilConnection/" + eemail.getText().toString() + "/" + epassword.getText().toString());
            }
        });
    }


    public void requestStringToCheckProfile(String url) {
        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {
                        //response is false if a user using this email has already existed
                        if (response.equals("false")) {
                            CharSequence text = "Wrong password";
                            int duration = Toast.LENGTH_SHORT;

                            Toast toast = Toast.makeText(getApplicationContext(), text, duration);
                            toast.show();

                        } else if(response.equals("False")) {
                            CharSequence text = "No account for this email";
                            int duration = Toast.LENGTH_SHORT;

                            Toast toast = Toast.makeText(getApplicationContext(), text, duration);
                            toast.show();

                        } else {
                            String[] responseSplit = response.split("_");

                            SharedPreferences.Editor editor = sharedPreferences.edit();

                            editor.putString("USERNAME", responseSplit[0]);
                            editor.putString("EMAIL", eemail.getText().toString());
                            editor.putString("PASSWORD", epassword.getText().toString());
                            // Factors
                            editor.putInt("POPULARITYFACTOR",Integer.valueOf(responseSplit[1]));
                            editor.putInt("METEOFACTOR",Integer.valueOf(responseSplit[2]));
                            editor.putInt("TEMPERATUREFACTOR",Integer.valueOf(responseSplit[3]));
                            editor.putInt("LOCALISATIONFACTOR",Integer.valueOf(responseSplit[4]));
                            editor.putInt("AFFLUENCEFACTOR",Integer.valueOf(responseSplit[5]));
                            editor.putInt("PRICEFACTOR",Integer.valueOf(responseSplit[6]));

                            editor.apply();

                            Intent ProfileActivity = new Intent(LogInActivity.this, ProfileActivity.class);
                            startActivity(ProfileActivity);
                            finish();
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

}
