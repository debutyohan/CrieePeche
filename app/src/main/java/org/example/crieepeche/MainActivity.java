package org.example.crieepeche;

import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.ContextMenu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.PopupMenu;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.Toolbar;

import com.squareup.okhttp.MediaType;
import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.RequestBody;
import com.squareup.okhttp.Response;

import org.example.crieepeche.R;
import org.json.JSONException;
import org.json.JSONObject;
import org.w3c.dom.Text;

import java.io.IOException;
import java.util.Arrays;

public class MainActivity extends AppCompatActivity {
    private Button btn_afficherbacs;
    private UserConnected userconnect;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        btn_afficherbacs = (Button) findViewById(R.id.btn_afficherbacs);
        btn_afficherbacs.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                gstBacs();
            }
        });

        userconnect = new UserConnected(MainActivity.this);
        if(userconnect.isconnect()){
            TextView txt_ifconnectuser = (TextView) findViewById(R.id.txt_ifconnectuser);
            txt_ifconnectuser.setText("Vous êtes connecté : "+userconnect.getLogin());
        }
        final TextView txt_title = (TextView) findViewById(R.id.textView_title);
        txt_title.setText("ACCUEIL");

        ImageView usermenu = (ImageView)findViewById(R.id.usermenu);
        usermenu.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View view) {
                // Initializing the popup menu and giving the reference as current context
                PopupMenu popupMenu = new PopupMenu(MainActivity.this, usermenu);

                // Inflating popup menu from popup_menu.xml file
                if(userconnect.isconnect()) {
                    popupMenu.getMenuInflater().inflate(R.menu.menuconnect, popupMenu.getMenu());
                }else{
                    popupMenu.getMenuInflater().inflate(R.menu.menu, popupMenu.getMenu());
                }
                popupMenu.setOnMenuItemClickListener(new PopupMenu.OnMenuItemClickListener() {
                    @Override
                    public boolean onMenuItemClick(MenuItem item) {
                        switch (item.getItemId()){
                            case R.id.option_1:
                                login();
                                return true;
                            case R.id.option_connect_1:
                                logout();
                                return true;
                            default:
                                System.exit(0);
                                return false;
                        }
                        }
                    });
                popupMenu.show();
                }

        });

    }

    public void gstBacs() {
        MainActivity.this.finishActivity(0);
        Intent intent = new Intent(this, gstBacs.class);
        startActivity(intent);
    }
    public void login() {
        MainActivity.this.finishActivity(0);
        Intent intent = new Intent(this, login.class);
        startActivity(intent);
    }

    private void logout()  {
        CustomDialog.ClickConfirmed listener = new CustomDialog.ClickConfirmed() {
            @Override
            public void clickconfirm() {
                new MainActivity.req_logout().execute();
            }
        };
        final CustomDialog dialog = new CustomDialog(this, listener, R.layout.dialog_deconnect, R.id.btn_dialog_deconnect_confirm, R.id.btn_dialog_deconnect_annuler);

        dialog.show();
    }
    private class req_logout extends AsyncTask<String, String, String>
    {
        private ProgressDialog pDialog;
        @Override
        protected String doInBackground(String... strings) {
            String token = userconnect.getToken();
            MediaType JSON = MediaType.parse("application/json; charset=utf-8");
            OkHttpClient client = new OkHttpClient();
            RequestBody body = RequestBody.create(JSON, "");
            Request request = new Request.Builder().url("http://192.168.119.197:8000/api/logoutpecheur").addHeader("Content-Type", "application/json").addHeader("Authorization", "Bearer "+token).post(body).build();
            Response response = null;
            try {
                response = client.newCall(request).execute();
                //Log.i("JSONReponse", response.body().string());
                return response.body().string();
            } catch (IOException e) {

            }
            return null;
        }
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            pDialog = new ProgressDialog(MainActivity.this);
            pDialog.setMessage("Déconnexion en cours ...");
            pDialog.setIndeterminate(false);
            pDialog.setCancelable(true);
            pDialog.show();
        }
        @Override
        protected void onPostExecute(String json) {
            pDialog.dismiss();
            String msg="";
            if(json==null){
                msg="En revanche, la déconnexion n'est pas faite correctement sur l'API : Impossible de joindre le serveur API, veuillez vérifier votre connexion Internet et que le serveur API est accessible";
            }else{
                // textViewDonnees.setText(json.toString());
                JSONObject c=null;
                try {
                    // Getting JSON Array from URL
                    JSONObject obj = new JSONObject(json);
                    if(obj.get("etatrequete").equals("Error")){
                        msg="En revanche, la déconnexion n'est pas faite correctement sur l'API : "+obj.get("message").toString();
                    }
                    if(obj.get("etatrequete").equals("Success")){
                        msg="La déconnexion sur l'API s'est faite correctement.";
                    }
                } catch (JSONException e) {
                    //e.printStackTrace();
                    Log.i("e",e.toString());
                }
            }
            userconnect.deconnect();
            Toast connectionsucess = Toast.makeText(MainActivity.this, "Vous avez été déconnecté depuis l'application. "+msg, Toast.LENGTH_LONG);
            connectionsucess.show();
            TextView txt_ifconnectuser = (TextView) findViewById(R.id.txt_ifconnectuser);
            txt_ifconnectuser.setText("Vous n’êtes pas connecté. Pour vous connectez, cliquer sur l’image en haut à droite");
        }
    }
}