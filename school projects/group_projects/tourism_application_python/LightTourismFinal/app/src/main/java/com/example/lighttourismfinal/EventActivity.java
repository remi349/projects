package com.example.lighttourismfinal;

import android.Manifest;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.provider.MediaStore;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;

public class EventActivity extends AppCompatActivity {

    Context c = this;
    Activity a = this;

    private Button addPictureBtn;
    private ImageView picture;
    private EditText nameEvent;
    private EditText description;
    private Button uploadBtn;

    private String descriptionStr;
    private String nameEventStr;
    private Bitmap bitmap;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_event);

        addPictureBtn = (Button) findViewById(R.id.add_picture_btn);
        picture = (ImageView) findViewById(R.id.picture);
        nameEvent = (EditText) findViewById(R.id.Name_of_the_event_ET);
        description = (EditText) findViewById(R.id.description_ET);
        uploadBtn = (Button) findViewById(R.id.upload_btn);

        //request for camera runtime permission
        if(ContextCompat.checkSelfPermission(EventActivity.this, Manifest.permission.CAMERA)
        != PackageManager.PERMISSION_GRANTED){
            ActivityCompat.requestPermissions(EventActivity.this, new String[]{
                    Manifest.permission.CAMERA
            }, 100);
        }

        addPictureBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // The user just clicked
                Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
                startActivityForResult(intent, 100);
            }
        });

        uploadBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (nameEvent.getText().toString().length()==0){
                    CharSequence text = "What's the name of your event ?";
                    int duration = Toast.LENGTH_SHORT;

                    Toast toast = Toast.makeText(getApplicationContext(), text, duration);
                    toast.show();
                } else {
                    String latitude = MySingleton.getInstance(c).getLocation(c, a)[0];
                    String longitude = MySingleton.getInstance(c).getLocation(c, a)[1];
                    String url = "http://137.194.210.201/interest/" + latitude + "/" + longitude + "/" + nameEvent.getText() + "/" + description.getText();

                    requestStringAndActualizeVisits(url);

                    Intent MapsActivity = new Intent(EventActivity.this, MapsActivity.class);
                    startActivity(MapsActivity);
                    finish();
                }
            }
        });

    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if(requestCode==100){
            bitmap = (Bitmap) data.getExtras().get("data");
            picture.setImageBitmap(bitmap);
        }
    }

    public void requestStringAndActualizeVisits(String url){
        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {
                        if (response.equals("False")){
                            CharSequence text = "This event already exist";
                            int duration = Toast.LENGTH_SHORT;

                            Toast toast = Toast.makeText(getApplicationContext(), text, duration);
                            toast.show();
                        }
                    }
                },
                new Response.ErrorListener() {
                    @SuppressLint("SetTextI18n")
                    @Override
                    //Action to perform in case http request fail
                    public void onErrorResponse(VolleyError error) {
                    }
                });

        // Add a request (in this example, called stringRequest) to your RequestQueue.
        MySingleton.getInstance(this).addToRequestQueue(stringRequest);
    }
}