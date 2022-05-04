package org.example.crieepeche;


import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import androidx.appcompat.app.AppCompatActivity;

import java.sql.Array;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class UserConnected extends AppCompatActivity {
    private String login;
    private String token;
    private String datelastsync;
    private SQLiteDatabase maBase;
    private BdHelper monBdHelper;
    private Context uncontext;
    public UserConnected(Context uncontext){
        monBdHelper = new BdHelper(uncontext, "bddCriePeche.db", null, 1);
        maBase = monBdHelper.getWritableDatabase();
        Cursor c = maBase.rawQuery("select login, token, datelastsync from Utilisateur;",null);
        if(c.getCount()==0){
            this.login=null;
            this.token=null;
            this.datelastsync=null;
        }
        while (c.moveToNext()) {
            this.login=c.getString(0);
            this.token=c.getString(1);
            this.datelastsync=c.getString(2);
        }
        maBase.close();
        this.uncontext=uncontext;
    }
    public UserConnected(Context uncontext, String login, String token)
    {
        this.login = login;
        this.token = token;
        SimpleDateFormat dtf = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
        Calendar calendar = Calendar.getInstance();
        Date dateObj = calendar.getTime();
        String formattedDate = dtf.format(dateObj);
        this.datelastsync = formattedDate;
        monBdHelper = new BdHelper(uncontext, "bddCriePeche.db", null, 1);
        maBase = monBdHelper.getWritableDatabase();
        maBase.execSQL("delete from Utilisateur;");
        maBase.execSQL("insert into Utilisateur VALUES (?,?,?);", new Object[]{login, token, formattedDate});
        maBase.close();
        this.uncontext=uncontext;
    }
    public String getLogin() {
        return login;
    }
    public String getToken(){
        return token;
    }
    public String getDatelastsync() {
        return datelastsync;
    }
    public boolean isconnect() {
        if(this.login==null){
            return false;
        }else{
            return true;
        }
    }
    public void deconnect(){
        this.login=null;
        this.token=null;
        this.datelastsync=null;
        monBdHelper = new BdHelper(this.uncontext, "bddCriePeche.db", null, 1);
        maBase = monBdHelper.getWritableDatabase();
        maBase.execSQL("delete from Utilisateur;");
    }
}