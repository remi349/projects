package com.example.lighttourismfinal;

import android.content.Intent;
import android.os.Bundle;
import android.os.CountDownTimer;

import androidx.appcompat.app.AppCompatActivity;

import com.example.lighttourismfinal.databinding.ActivityLoadScreenBinding;

public class LoadScreenActivity extends AppCompatActivity {

    private ActivityLoadScreenBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        binding = ActivityLoadScreenBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        new CountDownTimer(2000, 1000) {

            @Override
            public void onTick(long millisUntilFinished) {
            }

            @Override
            public void onFinish() {
                Intent MapsActivity = new Intent(LoadScreenActivity.this, MapsActivity.class);
                startActivity(MapsActivity);
                finish();
            }

        }.start();

    }
}