package org.example.crieepeche;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

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
    }

    public void gstBacs() {
        Intent intent = new Intent(this, gstBacs.class);
        startActivity(intent);
    }
}