package org.example.crieepeche;

import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.ContextMenu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.PopupMenu;
import android.widget.Toast;
import android.widget.Toolbar;

import org.example.crieepeche.R;

import java.util.Arrays;

public class MainActivity extends AppCompatActivity {
    private Button btn_afficherbacs;

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
        /*ActionBar actionBar = getSupportActionBar();
        actionBar.hide();*/

        ImageView usermenu = (ImageView)findViewById(R.id.usermenu);

        usermenu.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View view) {
                // Initializing the popup menu and giving the reference as current context
                PopupMenu popupMenu = new PopupMenu(MainActivity.this, usermenu);

                // Inflating popup menu from popup_menu.xml file
                popupMenu.getMenuInflater().inflate(R.menu.menu, popupMenu.getMenu());
                popupMenu.setOnMenuItemClickListener(new PopupMenu.OnMenuItemClickListener() {
                    @Override
                    public boolean onMenuItemClick(MenuItem item) {
                        switch (item.getItemId()){
                            case R.id.option_1:
                                Toast.makeText(MainActivity.this, "You Clicked ", Toast.LENGTH_SHORT).show();
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

<<<<<<< HEAD
    public void gstBacs() {
        Intent intent = new Intent(this, gstBacs.class);
=======

    public void listBacs() {
        Intent intent = new Intent(this, listBacs.class);
>>>>>>> a22634ba7a6af41b49056e6737c116e83af5a06e
        startActivity(intent);
    }
}