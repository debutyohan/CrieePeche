package org.example.crieepeche;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.Toast;

public class CustomDialog extends Dialog {
    interface ClickConfirmed {
        public void clickconfirm();
    }

    public Context context;

    private Button buttonOK;
    private Button buttonCancel;

    private CustomDialog.ClickConfirmed listener;

    public CustomDialog(Context context, CustomDialog.ClickConfirmed listener) {
        super(context);
        this.context = context;
        this.listener = listener;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.dialog_supprbacs);

        this.buttonOK = (Button) findViewById(R.id.btn_dialog_supprbacs_confirm);
        this.buttonCancel  = (Button) findViewById(R.id.btn_dialog_supprbacs_annuler);

        this.buttonOK .setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                buttonOKClick();
            }
        });
        this.buttonCancel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                buttonCancelClick();
            }
        });
    }

    // User click "OK" button.
    private void buttonOKClick()  {
        this.dismiss(); // Close Dialog

        if(this.listener!= null)  {
            this.listener.clickconfirm();
        }
    }

    // User click "Cancel" button.
    private void buttonCancelClick()  {
        this.dismiss();
    }
}