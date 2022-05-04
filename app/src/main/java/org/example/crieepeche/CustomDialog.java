package org.example.crieepeche;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.widget.Button;

public class CustomDialog extends Dialog {
    interface ClickConfirmed {
        public void clickconfirm();
    }

    public Context context;

    private Button buttonOK;
    private Button buttonCancel;
    private int idbuttonOK;
    private int idlayoutdialog;
    private int idbuttoncancel;
    private CustomDialog.ClickConfirmed listener;

    public CustomDialog(Context context, CustomDialog.ClickConfirmed listener, int idlayoutdialog, int idbuttonOK, int idbuttoncancel) {
        super(context);
        this.context = context;
        this.listener = listener;
        this.idbuttoncancel = idbuttoncancel;
        this.idlayoutdialog = idlayoutdialog;
        this.idbuttonOK = idbuttonOK;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(this.idlayoutdialog);

        this.buttonOK = (Button) findViewById(this.idbuttonOK);
        this.buttonCancel  = (Button) findViewById(this.idbuttoncancel);

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