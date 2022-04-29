package org.example.crieepeche;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.PopupMenu;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import org.json.JSONException;
import org.json.JSONObject;

import com.squareup.okhttp.MediaType;
import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.RequestBody;
import com.squareup.okhttp.Response;

import java.io.IOException;

public class login extends AppCompatActivity {
    private Button btn_login;
    private UserConnected userconnect;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        final TextView txt_title = (TextView) findViewById(R.id.textView_title);
        txt_title.setText("CONNEXION");

        btn_login = (Button) findViewById(R.id.btn_login_connect);
        btn_login.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                connect();
            }
        });
        ImageView iconaccueil = (ImageView)findViewById(R.id.iconmenu);
        iconaccueil.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View view) {
                login.this.finishActivity(0);
                Intent intent = new Intent(login.this, MainActivity.class);
                startActivity(intent);
            }

        });
        ImageView usermenu = (ImageView)findViewById(R.id.usermenu);
        usermenu.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View view) {
                // Initializing the popup menu and giving the reference as current context
                PopupMenu popupMenu = new PopupMenu(login.this, usermenu);

                // Inflating popup menu from popup_menu.xml file
                popupMenu.getMenuInflater().inflate(R.menu.menu, popupMenu.getMenu());
                popupMenu.setOnMenuItemClickListener(new PopupMenu.OnMenuItemClickListener() {
                    @Override
                    public boolean onMenuItemClick(MenuItem item) {
                        switch (item.getItemId()){
                            case R.id.option_1:
                                return true;
                            case R.id.option_2:
                                System.exit(0);
                                return true;
                            default:
                                return false;
                        }
                    }
                });
                popupMenu.show();
            }

        });
    }

    private void connect(){
        new JSONAsynchrone().execute();
    }
    private class JSONAsynchrone extends AsyncTask<String, String, String>
    {
        private ProgressDialog pDialog;
        @Override
        protected String doInBackground(String... strings) {
            MediaType JSON = MediaType.parse("application/json; charset=utf-8");
            OkHttpClient client = new OkHttpClient();
            JSONObject jsonObject = new JSONObject();
            EditText login = (EditText)findViewById(R.id.etxt_login_login);
            EditText password = (EditText)findViewById(R.id.etxt_login_password);
            try {
                jsonObject.put("login", login.getText().toString());
                jsonObject.put("password", password.getText().toString());
            } catch (JSONException e) {
                e.printStackTrace();
            }
            RequestBody body = RequestBody.create(JSON, jsonObject.toString());
            Request request = new Request.Builder().url("http://192.168.119.197:8000/api/loginpecheur").addHeader("Content-Type", "application/json").post(body).build();
            Response response = null;
            try {
                response = client.newCall(request).execute();
                //Log.i("JSONReponse", response.body().string());
                return response.body().string();
            } catch (IOException e) {
                TextView txt_error = (TextView) findViewById(R.id.txt_login_error);
                txt_error.setText("Impossible de joindre le serveur API, veuillez vérifier votre connexion Internet et que le serveur API est accessible");
            }
            return null;
        }
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            pDialog = new ProgressDialog(login.this);
            pDialog.setMessage("Connexion en cours ...");
            pDialog.setIndeterminate(false);
            pDialog.setCancelable(true);
            pDialog.show();
        }
        @Override
        protected void onPostExecute(String json) {
            pDialog.dismiss();
            if(json==null){
                return;
            }
            // textViewDonnees.setText(json.toString());
            JSONObject c=null;
            try {
                // Getting JSON Array from URL
                JSONObject obj = new JSONObject(json);
                if(obj.get("etatrequete").equals("Error")){
                    TextView txt_error = (TextView) findViewById(R.id.txt_login_error);
                    txt_error.setText("Erreur lors de la connexion à l'API : "+obj.get("message").toString());
                }
                if(obj.get("etatrequete").equals("Success")){
                    JSONObject obj_data = new JSONObject(obj.get("data").toString());
                    JSONObject obj_data_user = new JSONObject(obj_data.get("user").toString());
                    UserConnected unuser =new UserConnected(login.this, obj_data_user.get("login").toString(), obj_data.get("token").toString());
                    Toast connectionsucess = Toast.makeText(login.this, "Vous êtes connecté", Toast.LENGTH_LONG);
                    connectionsucess.show();
                    login.this.finishActivity(0);
                    Intent intent = new Intent(login.this, MainActivity.class);
                    startActivity(intent);

                }
            } catch (JSONException e) {
                //e.printStackTrace();
                Log.i("e",e.toString());
            }
        }
    }
}