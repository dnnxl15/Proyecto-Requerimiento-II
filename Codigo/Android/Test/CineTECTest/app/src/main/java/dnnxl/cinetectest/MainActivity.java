package dnnxl.cinetectest;

import android.net.wifi.WifiManager;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.net.Inet4Address;
import java.sql.Connection;
import java.sql.Statement;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import java.io.*;
import java.net.*;
import java.util.*;

public class MainActivity extends AppCompatActivity {

    ConnectionClass connectionClass = new ConnectionClass();

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit_movie);



        getMoviesFromDB(0);

    }

    private void getMoviesFromDB(int id) {

        AsyncTask<Integer, Void, Void> asyncTask = new AsyncTask<Integer, Void, Void>() {
            @Override
            protected Void doInBackground(Integer... movieIds) {

                OkHttpClient client = new OkHttpClient();
                Request request = new Request.Builder()
                        .url("http://172.18.15.193/movies.php?id=" + movieIds[0]) //Colocar aqui su string de ipv4, hay que agregar el dato de forma dinamica
                        .build();
                try {
                    Response response = client.newCall(request).execute();

                    JSONArray array = new JSONArray(response.body().string());

                    for (int i = 0; i < array.length(); i++) {

                        JSONObject object = array.getJSONObject(i);
                        Log.d("CREATION", object.toString());
                        System.out.println();

                        /*Movie movie = new Movie(object.getInt("id"), object.getString("movie_name"),
                                object.getString("movie_image"), object.getString("movie_genre"));

                        MainActivity.this.movies.add(movie);*/
                    }


                } catch (IOException e) {
                    Log.d("CREATION", e.toString());
                    e.printStackTrace();
                } catch (JSONException e) {
                    Log.d("CREATION", e.toString());
                    e.printStackTrace();
                }
                return null;
            }

            @Override
            protected void onPostExecute(Void aVoid) {
                //adapter.notifyDataSetChanged();
            }
        };

        Log.d("CREATION", "Termina");
        asyncTask.execute(id);
    }


}
