package org.example.crieepeche;

import static android.view.View.VISIBLE;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.CheckBox;
import android.widget.ListView;
import android.widget.PopupMenu;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.List;

public class gstBacs extends AppCompatActivity {
    private Button btn_gstbacs_add;
    private Button buttonOpenDialog;
    private GestionBD gestionBD;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_gstbacs);
        btn_gstbacs_add = (Button) findViewById(R.id.btn_gstbacs_add);
        btn_gstbacs_add.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {gstBacs_add(); }
        });
        final TextView txt_title = (TextView) findViewById(R.id.textView_title);
        txt_title.setText("GESTION DES BACS");
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
            bouton_suppr.setBackgroundColor(Color.rgb(242,199,205));
            final Button bouton_modif = (Button) findViewById(R.id.btn_gstbacs_modif);
            bouton_modif.setEnabled(false);
            bouton_modif.setBackgroundColor(Color.rgb(253,237,189));
        }else{
            ListView listViewBac = (ListView) findViewById(R.id.listView_bacs);
            listViewBac.setAdapter(new CustomListAdapter(this, list_bacs));
        }

        ImageView usermenu = (ImageView)findViewById(R.id.usermenu);

        usermenu.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View view) {
                // Initializing the popup menu and giving the reference as current context
                PopupMenu popupMenu = new PopupMenu(gstBacs.this, usermenu);

                // Inflating popup menu from popup_menu.xml file
                popupMenu.getMenuInflater().inflate(R.menu.menu, popupMenu.getMenu());
                popupMenu.setOnMenuItemClickListener(new PopupMenu.OnMenuItemClickListener() {
                    @Override
                    public boolean onMenuItemClick(MenuItem item) {
                        switch (item.getItemId()){
                            case R.id.option_1:
                                Toast.makeText(gstBacs.this, "You Clicked ", Toast.LENGTH_SHORT).show();
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

    private void gstBacs_add() {
        Intent intent = new Intent(this, gstBacs_add.class);
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
                Toast toastdeleted = Toast.makeText(gstBacs.this,"Les bacs ont bien été supprimés", Toast.LENGTH_LONG);
                toastdeleted.show();
            }
        };
        final CustomDialog dialog = new CustomDialog(this, listener);

        dialog.show();
    }
}
