package org.example.crieepeche;

import static android.view.View.VISIBLE;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;

import java.util.List;

public class gstBacs extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_gstbacs);
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

    }
}
