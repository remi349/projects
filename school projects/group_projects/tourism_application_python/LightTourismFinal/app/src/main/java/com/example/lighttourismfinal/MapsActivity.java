package com.example.lighttourismfinal;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.location.Address;
import android.location.Geocoder;
import android.location.LocationManager;
import android.os.Bundle;
import android.os.CountDownTimer;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.SearchView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.fragment.app.FragmentActivity;

import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.ImageLoader;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.StringRequest;
import com.example.lighttourismfinal.databinding.ActivityMapsBinding;
import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationServices;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;
import com.google.android.material.bottomsheet.BottomSheetBehavior;
import com.google.android.material.floatingactionbutton.FloatingActionButton;

import org.json.JSONObject;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;


public class MapsActivity extends FragmentActivity implements OnMapReadyCallback {

    Context c = this;
    Activity a = this;

    private GoogleMap mMap;
    private ActivityMapsBinding binding;
    private Button itineraryBtn;
    private Button userProfileBtn;
    private SearchView searchText;
    private TextView timer;

    private ImageView visitRecommendationIV1;
    private TextView visitRecommendationDescriptionTV1;
    private TextView visitRecommendationTV1;

    private ImageView visitRecommendationIV2;
    private TextView visitRecommendationDescriptionTV2;
    private TextView visitRecommendationTV2;

    private ImageView visitRecommendationIV3;
    private TextView visitRecommendationDescriptionTV3;
    private TextView visitRecommendationTV3;

    private FloatingActionButton floatingActionBtn;
    private SharedPreferences sharedPreferences;

    FusedLocationProviderClient fusedLocationProviderClient;

    // two array list for our lat long and location Name;
    private ArrayList<LatLng> latLngArrayList;

    @SuppressLint("WrongThread")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        /********************************* Map part *******************************/

        binding = ActivityMapsBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        // initializing our array list.
        latLngArrayList = new ArrayList<>();

        //Initialize FusedLocationProviderClient
        fusedLocationProviderClient = LocationServices.getFusedLocationProviderClient(this);

        // Obtain the SupportMapFragment and get notified when the map is ready to be used.
        SupportMapFragment mapFragment = (SupportMapFragment) getSupportFragmentManager()
                .findFragmentById(R.id.map);

        /**
         * Search bar code
         */

        searchText = (SearchView) findViewById(R.id.map_activity_search_text);

        // adding on query listener for our search view.
        searchText.setOnQueryTextListener(new SearchView.OnQueryTextListener() {
            @Override
            public boolean onQueryTextSubmit(String query) {
                // on below line we are getting the
                // location name from search view.
                String location = searchText.getQuery().toString();

                // below line is to create a list of address
                // where we will store the list of all address.
                List<Address> addressList = null;

                // checking if the entered location is null or not.
                if (location != null || location.equals("")) {
                    // on below line we are creating and initializing a geo coder.
                    Geocoder geocoder = new Geocoder(MapsActivity.this);
                    try {
                        // on below line we are getting location from the
                        // location name and adding that location to address list.
                        addressList = geocoder.getFromLocationName(location, 1);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    // on below line we are getting the location
                    // from our list a first position.
                    Address address = addressList.get(0);

                    // on below line we are creating a variable for our location
                    // where we will add our locations latitude and longitude.
                    LatLng latLng = new LatLng(address.getLatitude(), address.getLongitude());

                    // on below line we are adding marker to that position.
                    Marker marker = mMap.addMarker(new MarkerOptions().position(latLng).title(location).icon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_AZURE)));

                    // below line is to animate camera to that position.
                    mMap.animateCamera(CameraUpdateFactory.newLatLngZoom(latLng, 14));
                    //Start a timer to simulate the life expectancy of the marker
                    MarkerCountDownTimer markerCountDownTimer = new MarkerCountDownTimer(10000,1000,marker);
                    markerCountDownTimer.start();
                }
                return false;
            }

            @Override
            public boolean onQueryTextChange(String newText) {
                return false;
            }
        });

        mapFragment.getMapAsync(this);


        /**************************** get Shared Preferences *************************/

        Context context = getApplicationContext();
        sharedPreferences =  context.getSharedPreferences("profile", Context.MODE_PRIVATE);


        /**************************** Graphic interface part *************************/

        userProfileBtn = (Button) findViewById(R.id.map_activity_user_profile_btn);
        floatingActionBtn = findViewById(R.id.floating_btn);
        timer = (TextView) findViewById(R.id.timer);


        floatingActionBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent EventActivity = new Intent(MapsActivity.this, EventActivity.class);
                startActivity(EventActivity);
            }
        });

        userProfileBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // The user just clicked
                Intent ProfileActivity = new Intent(MapsActivity.this, ProfileActivity.class);
                startActivity(ProfileActivity);
            }
        });


        /****************************** Bottom sheet *******************************/

        visitRecommendationIV1 = (ImageView) findViewById(R.id.visit_recommendation_imageview1);
        visitRecommendationDescriptionTV1 = (TextView) findViewById(R.id.visit_recommendation_description_textview1);
        visitRecommendationTV1 = (TextView) findViewById(R.id.visit_recommendation_textview1);

        visitRecommendationIV2 = (ImageView) findViewById(R.id.visit_recommendation_imageview2);
        visitRecommendationDescriptionTV2 = (TextView) findViewById(R.id.visit_recommendation_description_textview2);
        visitRecommendationTV2 = (TextView) findViewById(R.id.visit_recommendation_textview2);

        visitRecommendationIV3 = (ImageView) findViewById(R.id.visit_recommendation_imageview3);
        visitRecommendationDescriptionTV3 = (TextView) findViewById(R.id.visit_recommendation_description_textview3);
        visitRecommendationTV3 = (TextView) findViewById(R.id.visit_recommendation_textview3);

        BottomSheetBehavior bottomSheetBehavior = BottomSheetBehavior.from(findViewById(R.id.includedBottomSheet));
        bottomSheetBehavior.setState(BottomSheetBehavior.STATE_COLLAPSED);



        /*** send the user location each 5 minutes to the server to actualize enable visits ****/

        AlertSessionCountDownTimer alertSessionCountDownTimer = new AlertSessionCountDownTimer(5000, 1000);
        alertSessionCountDownTimer.start();

    }







    @Override
    public void onMapReady(GoogleMap googleMap) {
        mMap = googleMap;

        LatLng palaiseau = new LatLng(48.71595449470986, 2.22999057469401);
        mMap.moveCamera(CameraUpdateFactory.newLatLng(palaiseau));
        mMap.animateCamera(CameraUpdateFactory.newLatLngZoom(palaiseau, 16), 1000, null);

        // adding on click listener to marker of google maps.
        mMap.setOnMarkerClickListener(new GoogleMap.OnMarkerClickListener() {
            @Override
            public boolean onMarkerClick(Marker marker) {
                // on marker click we are getting the title of our marker
                // which is clicked and displaying it in a toast message.
                String markerName = marker.getTitle();
                String[] name_desc = markerName.split("_");
                if (name_desc.length==2){
                    Toast.makeText(MapsActivity.this, name_desc[1], Toast.LENGTH_LONG).show();
                }
                return false;
            }
        });

    }


    /*************************** communicate with the server in http - Volley *******************/

    /**
     * Request a JSONObject from the provided url
     * @param mParams
     * @param url
     */
    public void requestJson(JSONObject mParams, String url) {
        JsonObjectRequest jsonObjectRequest = new JsonObjectRequest(Request.Method.GET, url,
                mParams, new Response.Listener<JSONObject>() {
            @Override
            public void onResponse(JSONObject jsonObject) {

            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError volleyError) {

            }
        });
        //setTag
        jsonObjectRequest.setTag(url);
        // Access the RequestQueue through your singleton class.
        MySingleton.getInstance(this).addToRequestQueue(jsonObjectRequest);
    }

    /**
     * Request the best visits according to the location and the preferences of the user
     * @param url
     */
    public void requestStringAndActualizeVisits(String url){
        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                new Response.Listener<String>() {
                    @Override
                    //Action to perform with the response of the http request
                    public void onResponse(String response) {
                        String[] responseSplit = response.split(";");
                        if (responseSplit.length < 3){
                            visitRecommendationTV1.setText("Error string length != 3");
                            visitRecommendationTV2.setText("Error string length != 3");
                            visitRecommendationTV3.setText("Error string length != 3");
                        }
                        else {
                            visitRecommendationTV1.setText(responseSplit[0]);
                            visitRecommendationDescriptionTV1.setText("Description : " + responseSplit[1]);
                            setImage(visitRecommendationIV1,responseSplit[2]);

                            visitRecommendationTV2.setText(responseSplit[3]);
                            visitRecommendationDescriptionTV2.setText("Description : " + responseSplit[4]);
                            setImage(visitRecommendationIV2,responseSplit[5]);

                            visitRecommendationTV3.setText(responseSplit[6]);
                            visitRecommendationDescriptionTV3.setText("Description : " + responseSplit[7]);
                            setImage(visitRecommendationIV3,responseSplit[8]);
                        }
                    }
                },
                new Response.ErrorListener() {
                    @SuppressLint("SetTextI18n")
                    @Override
                    //Action to perform in case http request fail
                    public void onErrorResponse(VolleyError error) {
                        visitRecommendationTV1.setText(R.string.no_activity_found);
                        visitRecommendationTV2.setText(R.string.no_activity_found);
                        visitRecommendationTV3.setText(R.string.no_activity_found);
                    }
                });

        // Add a request (in this example, called stringRequest) to your RequestQueue.
        MySingleton.getInstance(this).addToRequestQueue(stringRequest);
    }


    /**
     * Request the event to add them on the map of the user
     * @param url
     */
    public void requestEventAndActualize(String url){
        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                new Response.Listener<String>() {
                    @Override
                    //Action to perform with the response of the http request
                    public void onResponse(String response) {
                        String[] responseSplit = response.split(";"); //nom_description_long_lat

                        // below line is to add marker to google maps
                        for (int i = 0; i < responseSplit.length; i++) {
                            for (int j=0; j<4;j++) {
                                String[] eventi = responseSplit[i].split("_");
                                latLngArrayList.add(new LatLng(Integer.parseInt(eventi[2]), Integer.parseInt(eventi[3])));

                                // adding marker to each location on google maps
                                Marker marker = mMap.addMarker(new MarkerOptions().position(latLngArrayList.get(i)).title(eventi[0] + "_" + eventi[1])); // title contains "name_description"

                                //Start a timer to simulate the life expectancy of the marker
                                MarkerCountDownTimer markerCountDownTimer = new MarkerCountDownTimer(10000,1000,marker);
                                markerCountDownTimer.start();
                            }
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


    /**
     * Set a ImageView from a http request.
     * @param mImageView
     * @param urlImage
     */
    public void setImage(ImageView mImageView, String urlImage){
        ImageLoader mImageLoader;
        // Get the ImageLoader through your singleton class.
        mImageLoader = MySingleton.getInstance(this).getImageLoader();
        mImageLoader.get(urlImage, ImageLoader.getImageListener(mImageView, R.drawable.ic_baseline_highlight_off_24, R.drawable.ic_baseline_highlight_off_24));
    }

    /***************************** timer to send http request each minute ***************/

    public class AlertSessionCountDownTimer extends CountDownTimer {

        public AlertSessionCountDownTimer(long startTime, long interval) {
            super(startTime, interval);
        }

        @Override
        public void onFinish() {
            //YOUR LOGIC ON FINISH 10 SECONDS
            MySingleton.getInstance(c).setLocationManager((LocationManager) getSystemService(Context.LOCATION_SERVICE));
            if (!MySingleton.getInstance(c).getLocationManager().isProviderEnabled(LocationManager.GPS_PROVIDER)) {
                MySingleton.getInstance(c).OnGPS(c);
            } else {
                String latitude = MySingleton.getInstance(c).getLocation(c,a)[0];
                String longitude = MySingleton.getInstance(c).getLocation(c,a)[1];
                String url = "http://137.194.210.201/visits/" + sharedPreferences.getString("EMAIL","t naz") + "/" + latitude + "/" + longitude;
                requestStringAndActualizeVisits(url);
                requestEventAndActualize("http://137.194.210.201/interest/update");
                timer.setText("00:00:00");
                AlertSessionCountDownTimer counter = new AlertSessionCountDownTimer(30000, 1000);
                counter.start();
            }
        }

        @Override
        public void onTick(long millisUntilFinished) {
            //YOUR LOGIC ON TICK
            // Used for formatting digit to be in 2 digits only
            NumberFormat f = new DecimalFormat("00");
            long hour = (millisUntilFinished / 3600000) % 24;
            long min = (millisUntilFinished / 60000) % 60;
            long sec = (millisUntilFinished / 1000) % 60;
            timer.setText(f.format(hour) + ":" + f.format(min) + ":" + f.format(sec));
        }
    }



    /***************************** timer to set life time of markers ***************/

    public class MarkerCountDownTimer extends CountDownTimer {

        private Marker marker;

        public MarkerCountDownTimer(long startTime, long interval, Marker marker) {
            super(startTime, interval);
            this.marker = marker;
        }

        @Override
        public void onFinish() {
            marker.remove();
        }

        @Override
        public void onTick(long millisUntilFinished) {

        }
    }
















    /************************************************************************************/

    /** button useful for testing
     <Button
     android:id="@+id/map_activity_itinerary_btn"
     android:layout_width="60dp"
     android:layout_height="60dp"
     android:background="@drawable/round_button"

     app:layout_constraintBottom_toBottomOf="parent"
     app:layout_constraintEnd_toStartOf="@+id/map_activity_user_profile_btn"
     app:layout_constraintStart_toEndOf="@id/map_activity_search_text"
     app:layout_constraintTop_toTopOf="parent" />

     itineraryBtn = (Button) findViewById(R.id.map_activity_itinerary_btn);

     itineraryBtn.setOnClickListener(new View.OnClickListener() {
    @Override
    public void onClick(View v) {
    // The user just clicked
    //Intent ItineraryActivity = new Intent(MapsActivity.this, ItineraryActivity.class);
    //startActivity(ItineraryActivity);
    setImage(visitRecommendationIV1,"https://cdn.britannica.com/66/80466-050-2E125F5C/Arc-de-Triomphe-Paris-France.jpg");
    }
    });*/

    /******************************* request using apach *********************************

    public class RequestTask extends AsyncTask<String, String, String> {

        @Override
        protected String doInBackground(String... uri) {
            HttpClient httpclient = new DefaultHttpClient();
            HttpResponse response;
            String responseString = null;
            try {
                response = httpclient.execute(new HttpGet(uri[0]));
                StatusLine statusLine = response.getStatusLine();
                if(statusLine.getStatusCode() == HttpStatus.SC_OK){
                    ByteArrayOutputStream out = new ByteArrayOutputStream();
                    response.getEntity().writeTo(out);
                    responseString = out.toString();
                    out.close();
                } else{
                    //Closes the connection.
                    response.getEntity().getContent().close();
                    throw new IOException(statusLine.getReasonPhrase());
                }
            } catch (ClientProtocolException e) {
                //TODO Handle problems..
                visitRecommendationTV1.setText("morche po :(");
            } catch (IOException e) {
                //TODO Handle problems..
            }
            return responseString;
        }

        @Override
        protected void onPostExecute(String result) {
            super.onPostExecute(result);
            //Do anything with response..
            visitRecommendationTV1.setText(result);
        }

    }


    private class AsyncTaskExample extends AsyncTask<String, String, Bitmap> {
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            p = new ProgressDialog(MapsActivity.this);
            p.setMessage("Please wait...It is downloading");
            p.setIndeterminate(false);
            p.setCancelable(false);
            p.show();
        }
        @Override
        protected Bitmap doInBackground(String... strings) {
            try {
                ImageUrl = new URL(strings[0]);
                HttpURLConnection conn = (HttpURLConnection) ImageUrl.openConnection();
                conn.setDoInput(true);
                conn.connect();
                is = conn.getInputStream();
                BitmapFactory.Options options = new BitmapFactory.Options();
                options.inPreferredConfig = Bitmap.Config.RGB_565;
                bmImg = BitmapFactory.decodeStream(is, null, options);
            } catch (IOException e) {
                e.printStackTrace();
            }
            return bmImg;
        }
        @Override
        protected void onPostExecute(Bitmap bitmap) {
            super.onPostExecute(bitmap);
            if(visitRecommendationIV1!=null) {
                p.hide();
                visitRecommendationIV1.setImageBitmap(bitmap);
            }else {
                p.show();
            }
        }
    }
     ***********************************************************************/

}