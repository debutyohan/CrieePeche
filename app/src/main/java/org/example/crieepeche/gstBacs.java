package org.example.crieepeche;

import static android.view.View.VISIBLE;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.PopupMenu;
import android.widget.TextView;
import android.widget.Toast;

import java.util.List;

public class gstBacs extends AppCompatActivity {
    private Button btn_gstbacs_add;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_gstbacs);
        btn_gstbacs_add = (Button) findViewById(R.id.btn_gstbacs_add);
        btn_gstbacs_add.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {gstBacs_add(); }
        });
        GestionBD gestionBD = new GestionBD(this);
        gestionBD.open();
        List<Bac> list_bacs = gestionBD.donneBacs();
        if(list_bacs.size()==0){
            final TextView textview = (TextView) findViewById(R.id.txt_nobacs);
            textview.setVisibility(VISIBLE);
        }else{
            final ListView listView = (ListView) findViewById(R.id.listView_bacs);
            listView.setAdapter(new CustomListAdapter(this, list_bacs));
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
}
