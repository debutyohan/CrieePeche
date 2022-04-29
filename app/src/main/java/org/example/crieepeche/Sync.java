package org.example.crieepeche;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;


public class Sync {
    private boolean issync;
    private SQLiteDatabase maBase;
    private BdHelper monBdHelper;
    private Context uncontext;
    public Sync(Context uncontext){
        monBdHelper = new BdHelper(uncontext, "bddCriePeche.db", null, 1);
        maBase = monBdHelper.getWritableDatabase();
        Cursor c = maBase.rawQuery("select issync from Sync;",null);
        while (c.moveToNext()) {
            int sync = Integer.parseInt(c.getString(0));
            if(sync==0){
                this.issync=false;
            }else{
                this.issync=true;
            }
        }
        maBase.close();
    }
    public boolean getIssync(){
        return this.issync;
    }
    public void unsync(){
        maBase = monBdHelper.getWritableDatabase();
        maBase.execSQL("update Sync set issync=0");
        maBase.close();
        this.issync=false;
    }
    public void sync(){
        maBase = monBdHelper.getWritableDatabase();
        maBase.execSQL("update Sync set issync=1");
        maBase.close();
        this.issync=true;
    }
    public boolean issync(){
        return this.issync;
    }
}
