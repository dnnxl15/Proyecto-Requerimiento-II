package dnnxl.cinetectest;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import java.sql.Connection;
import java.sql.Statement;

public class MainActivity extends AppCompatActivity {

    ConnectionClass connectionClass = new ConnectionClass();

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit_movie);




    }


}
