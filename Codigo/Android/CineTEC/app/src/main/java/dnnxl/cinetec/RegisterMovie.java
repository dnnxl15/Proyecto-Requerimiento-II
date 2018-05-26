package dnnxl.cinetec;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.DataOutputStream;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

public class RegisterMovie extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register_movie);
        Button registerBtnMovie = (Button) findViewById(R.id.registerMovie_registerButton);
        registerBtnMovie.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                EditText nameText = findViewById(R.id.registerMovie_name);
                EditText releaseText = findViewById(R.id.registerMovie_release);
                EditText genderText = findViewById(R.id.registerMovie_gender);
                EditText directorText = findViewById(R.id.registerMovie_director);
                String name = nameText.getText().toString();
                int release = Integer.parseInt(releaseText.getText().toString());
                String gender = genderText.getText().toString();
                String director = directorText.getText().toString();
                try {
                    URL url = new URL("http://localhost:51732/api/Administrator"); // Cambiar con su servidor
                    String type = "application/json";
                    HttpURLConnection httpURLConnection = (HttpURLConnection) url.openConnection();
                    httpURLConnection.setDoOutput(true);
                    httpURLConnection.setRequestMethod("POST");
                    httpURLConnection.setRequestProperty("Content-Type", type);
                    httpURLConnection.connect();
                    // Agregar los parámetros
                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("gender", gender);
                    jsonObject.put("director", director);
                    jsonObject.put("name", name);
                    jsonObject.put("year", release);
                    jsonObject.put("administrator", "");

                    DataOutputStream wr = new DataOutputStream(httpURLConnection.getOutputStream());
                    wr.writeBytes(jsonObject.toString());
                    wr.flush();
                    wr.close();

                } catch (MalformedURLException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                } catch (JSONException e) {
                    e.printStackTrace();
                }
                //Intent pIntent = new Intent(registerMovie.this, main.class);
                //startActivity(pIntent);
            }
        });
    }
}
