package org.example.crieepeche;

import static android.view.View.VISIBLE;

import androidx.appcompat.app.AppCompatActivity;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.CheckBox;
import android.widget.ListView;
import android.widget.PopupMenu;
import android.widget.TextView;
import android.widget.Toast;

import com.squareup.okhttp.MediaType;
import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.RequestBody;
import com.squareup.okhttp.Response;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class gstBacs extends AppCompatActivity {
    private Button btn_gstbacs_add;
    private Button buttonOpenDialog;
    private GestionBD gestionBD;
    private UserConnected userconnect;
    private Sync sync;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_gstbacs);
        btn_gstbacs_add = (Button) findViewById(R.id.btn_gstbacs_add);
        btn_gstbacs_add.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {gstBacs_add(); }
        });
        Button btn_gstbacs_sync = (Button) findViewById(R.id.btn_gstbacs_sync);
        btn_gstbacs_sync.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {new gstBacs.req_sync_lots().execute(); }
        });
        final TextView txt_title = (TextView) findViewById(R.id.textView_title);
        txt_title.setText("GESTION DES BACS");
        userconnect = new UserConnected(gstBacs.this);
        sync = new Sync(gstBacs.this);
        if(userconnect.isconnect()) {
            Button bouton_synchro = (Button) findViewById(R.id.btn_gstbacs_sync);
            bouton_synchro.setEnabled(true);
            bouton_synchro.setBackgroundColor(Color.rgb(44, 136, 217));
            TextView textView_ifconnect = (TextView) findViewById(R.id.txt_gstbacs_ifconnect);
            textView_ifconnect.setVisibility(View.INVISIBLE);
        }
        if(!sync.issync()){
            TextView txt_ifsync = (TextView) findViewById(R.id.txt_gstbacs_ifnotsync);
            txt_ifsync.setVisibility(VISIBLE);
        }
        gestionBD = new GestionBD(this);
        gestionBD.open();
        List<Bac> list_bacs = gestionBD.donneBacs();
        this.buttonOpenDialog = (Button) this.findViewById(R.id.btn_gstbacs_del);
        this.buttonOpenDialog.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ListView listViewBac = (ListView) findViewById(R.id.listView_bacs);
                boolean ischeck=false;
                for(int i=0; i<listViewBac.getChildCount();i++){
                    CheckBox uncheckbox = listViewBac.getChildAt(i).findViewById(R.id.chbx_bac);
                    if(uncheckbox.isChecked()){
                        ischeck=true;
                        break;
                    }
                }
                if(!ischeck){
                    Toast toastnochecked = Toast.makeText(gstBacs.this,"Aucun bac n'a été sélectionné", Toast.LENGTH_LONG);
                    toastnochecked.show();
                }else{
                    buttonOpenDialogClicked();
                }
            }
        });
        if(list_bacs.size()==0){
            final TextView textview = (TextView) findViewById(R.id.txt_nobacs);
            textview.setVisibility(VISIBLE);
            final Button bouton_suppr = (Button) findViewById(R.id.btn_gstbacs_del);
            bouton_suppr.setEnabled(false);
            bouton_suppr.setBackgroundColor(Color.argb(73, 211,69,91));
            final Button bouton_modif = (Button) findViewById(R.id.btn_gstbacs_modif);
            bouton_modif.setEnabled(false);
            bouton_modif.setBackgroundColor(Color.argb(73,247,195,37));
        }else{
            ListView listViewBac = (ListView) findViewById(R.id.listView_bacs);
            listViewBac.setAdapter(new CustomListAdapter(this, list_bacs));
        }

        ImageView iconaccueil = (ImageView)findViewById(R.id.iconmenu);
        iconaccueil.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View view) {
                gstBacs.this.finishActivity(0);
                Intent intent = new Intent(gstBacs.this, MainActivity.class);
                startActivity(intent);
            }

        });

        userconnect = new UserConnected(gstBacs.this);
        ImageView usermenu = (ImageView)findViewById(R.id.usermenu);
        usermenu.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View view) {
                // Initializing the popup menu and giving the reference as current context
                PopupMenu popupMenu = new PopupMenu(gstBacs.this, usermenu);

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

    private void gstBacs_add() {
        gstBacs.this.finishActivity(0);
        Intent intent = new Intent(this, gstBacs_add.class);
        startActivity(intent);
    }


    public void login() {
        gstBacs.this.finishActivity(0);
        Intent intent = new Intent(this, login.class);
        startActivity(intent);
    }

    private void buttonOpenDialogClicked()  {
        CustomDialog.ClickConfirmed listener = new CustomDialog.ClickConfirmed() {
            @Override
            public void clickconfirm() {
                ListView listViewBac = (ListView) findViewById(R.id.listView_bacs);
                int numbacdeleted=0;
                for(int i=0; i<listViewBac.getChildCount();i++){
                    CheckBox uncheckbox = listViewBac.getChildAt(i).findViewById(R.id.chbx_bac);
                    if(uncheckbox.isChecked()){
                        gestionBD.deleteBac(i+numbacdeleted);
                        numbacdeleted--;
                    }
                }
                List<Bac> list_bacs = gestionBD.donneBacs();
                if(list_bacs.size()==0){
                    final TextView textview = (TextView) findViewById(R.id.txt_nobacs);
                    textview.setVisibility(VISIBLE);
                    final Button bouton_suppr = (Button) findViewById(R.id.btn_gstbacs_del);
                    bouton_suppr.setEnabled(false);
                    bouton_suppr.setBackgroundColor(Color.rgb(242,199,205));
                    final Button bouton_modif = (Button) findViewById(R.id.btn_gstbacs_modif);
                    bouton_modif.setEnabled(false);
                    bouton_modif.setBackgroundColor(Color.rgb(253,237,189));
                }else{
                    listViewBac.setAdapter(new CustomListAdapter(gstBacs.this, list_bacs));
                }
                sync.unsync();
                TextView txt_ifsync = (TextView) findViewById(R.id.txt_gstbacs_ifnotsync);
                txt_ifsync.setVisibility(VISIBLE);
                Toast toastdeleted = Toast.makeText(gstBacs.this,"Les bacs ont bien été supprimés", Toast.LENGTH_LONG);
                toastdeleted.show();
            }
        };
        final CustomDialog dialog = new CustomDialog(this, listener, R.layout.dialog_supprbacs, R.id.btn_dialog_supprbacs_confirm, R.id.btn_dialog_supprbacs_annuler);

        dialog.show();
    }

    private void logout()  {
        CustomDialog.ClickConfirmed listener = new CustomDialog.ClickConfirmed() {
            @Override
            public void clickconfirm() {
                new gstBacs.req_logout().execute();
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
            Request request = new Request.Builder().url("http://"+getString(R.string.api_host_ip)+":8000/api/logoutpecheur").addHeader("Content-Type", "application/json").addHeader("Authorization", "Bearer "+token).post(body).build();
            Response response = null;
            try {
                response = client.newCall(request).execute();
                return response.body().string();
            } catch (IOException e) {

            }
            return null;
        }
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            pDialog = new ProgressDialog(gstBacs.this);
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
                    // e.printStackTrace();
                }
            }
            userconnect.deconnect();
            Toast connectionsucess = Toast.makeText(gstBacs.this, "Vous avez été déconnecté depuis l'application. "+msg, Toast.LENGTH_LONG);
            connectionsucess.show();
            gstBacs.this.finishActivity(0);
            Intent intent = new Intent(gstBacs.this, MainActivity.class);
            startActivity(intent);
        }
    }

    private class req_sync_lots extends AsyncTask<String, String, String>
    {
        private ProgressDialog pDialog;
        @Override
        protected String doInBackground(String... strings) {
            String token = userconnect.getToken();
            MediaType JSON = MediaType.parse("application/json; charset=utf-8");
            OkHttpClient client = new OkHttpClient();
            JSONObject datalistebacs = new JSONObject();
            JSONArray listebacsput = new JSONArray();
            ArrayList<Bac> listebacs = gestionBD.donneBacs();
            for (Bac unbac:listebacs) {
                JSONObject jsonObject = new JSONObject();
                try {
                    jsonObject.put("id", unbac.getNumBac());
                    jsonObject.put("espece", unbac.getIdEspece());
                    jsonObject.put("presentation", unbac.getIdPresentation());
                    jsonObject.put("typebac", unbac.getTypeBac());
                } catch (JSONException e) {
                    e.printStackTrace();
                }
                listebacsput.put(jsonObject);
            }
            try {
                datalistebacs.put("lots", listebacsput);
            } catch (JSONException e) {
                e.printStackTrace();
            }
            EditText login = (EditText)findViewById(R.id.etxt_login_login);
            EditText password = (EditText)findViewById(R.id.etxt_login_password);
            RequestBody body = RequestBody.create(JSON, datalistebacs.toString());
            Request request = new Request.Builder().url("http://"+getString(R.string.api_host_ip)+":8000/api/synclots").addHeader("Content-Type", "application/json").addHeader("Authorization", "Bearer "+token).post(body).build();
            Response response = null;
            try {
                response = client.newCall(request).execute();
                return response.body().string();
            } catch (IOException e) {

            }
            return null;
        }
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            pDialog = new ProgressDialog(gstBacs.this);
            pDialog.setMessage("Synchronisation en cours ...");
            pDialog.setIndeterminate(false);
            pDialog.setCancelable(true);
            pDialog.show();
        }
        @Override
        protected void onPostExecute(String json) {
            pDialog.dismiss();
            String msg="";
            if(json==null){
                msg="Impossible de joindre le serveur API, veuillez vérifier votre connexion Internet et que le serveur API est accessible";
                TextView txt_gstbacs_msgerrorsync = (TextView) findViewById(R.id.txt_gstbacs_msgerrorsync);
                txt_gstbacs_msgerrorsync.setText(msg);
                return;
            }else{
                // textViewDonnees.setText(json.toString());
                JSONObject c=null;
                try {
                    // Getting JSON Array from URL
                    JSONObject obj = new JSONObject(json);
                    if(obj.get("etatrequete").equals("Error")){
                        msg="Synchronisation échouée : "+obj.get("message").toString();
                    }
                } catch (JSONException e) {
                    // e.printStackTrace();
                }
                TextView txt_gstbacs_msgerrorsync = (TextView) findViewById(R.id.txt_gstbacs_msgerrorsync);
                txt_gstbacs_msgerrorsync.setText(msg);
                if(msg==""){
                    sync.sync();
                    Log.i("JSON", "OK");
                    Toast connectionsucess = Toast.makeText(gstBacs.this, "Les bacs ont été synchronisés ", Toast.LENGTH_LONG);
                    connectionsucess.show();
                    TextView txt_ifsync = (TextView) findViewById(R.id.txt_gstbacs_ifnotsync);
                    txt_ifsync.setVisibility(View.INVISIBLE);
                }
            }
        }
    }
}
