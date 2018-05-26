package dnnxl.proyecto_ii;

import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.content.Context;
import android.os.AsyncTask;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import java.util.HashMap;
import java.util.Map;


public class SignUp extends AppCompatActivity {

    private EditText nameText;
    private EditText usernameText;
    private EditText emailText;
    private EditText passwordText;
    private Button signUpButton;
    private CheckBox admin;
    private CheckBox regularUser;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sign_up);
        nameText = findViewById(R.id.signUp_name);
        usernameText = findViewById(R.id.signUp_username);
        emailText = findViewById(R.id.signUp_mail);
        passwordText = findViewById(R.id.signUp_password);
        admin = findViewById(R.id.signUp_administratorCheck);
        regularUser = findViewById(R.id.signUp_regularUserCheck);
        signUpButton = findViewById(R.id.signUp_loginButton);
        signUpButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                //boolean adminValue = admin.isChecked();
                //boolean regularValue = regularUser.isChecked();
                if (admin.isChecked() && regularUser.isChecked()) {
                    AlertDialog.Builder dialogBuilder = new AlertDialog.Builder(SignUp.this);
                    dialogBuilder.setMessage("Choose Administrator or Regular user");
                    dialogBuilder.setCancelable(true).setTitle("Error");
                    dialogBuilder.create().show();
                } else {

                    executeService();
                    emailText.setText("");
                    passwordText.setText("");
                }
            }
        });
    }

    public void executeService()
    {
        String name = nameText.getText().toString();
        String username = usernameText.getText().toString();
        String email = emailText.getText().toString();
        String password = passwordText.getText().toString();
        ServiceTask newService = new ServiceTask(this, "http://localhost:51732/api/Administrator", username, password,name,email);
        newService.execute();
    }






}
