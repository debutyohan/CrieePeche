package org.example.crieepeche;


import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.CheckBox;
import android.widget.ImageView;
import android.widget.TextView;
import java.util.List;

public class CustomListAdapter extends BaseAdapter {
    private List<Bac> listData;
    private LayoutInflater layoutInflater;
    private Context context;
    public CustomListAdapter(Context aContext, List<Bac> listData) {
        this.context = aContext;
        this.listData = listData;
        layoutInflater = LayoutInflater.from(aContext);
    }
    @Override
    public int getCount() {
        return listData.size();
    }
    @Override
    public Object getItem(int position) {
        return listData.get(position);
    }
    @Override
    public long getItemId(int position) {
        return position;
    }
    public View getView(int position, View convertView, ViewGroup parent) {
        ViewHolder holder;
        if (convertView == null) {
            convertView = layoutInflater.inflate(R.layout.activity_listbacs,
                    null);
            holder = new ViewHolder();
            holder.checkBox_bac = (CheckBox)
                    convertView.findViewById(R.id.chbx_bac);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }
        Bac unbac = this.listData.get(position);
        holder.checkBox_bac.setText(unbac.toString());
        return convertView;
    }
    // Find Image ID corresponding to the name of the image (in the directory mipmap).
    public int getMipmapResIdByName(String resName) {
        String pkgName = context.getPackageName();
        // Return 0 if not found.
        int resID = context.getResources().getIdentifier(resName ,
                "mipmap", pkgName);
        Log.i("CustomListView", "Res Name: "+ resName+"==> Res ID = "+
                resID);
        return resID;
    }
    // classe nestée dans la classe CustomListAdapter
    static class ViewHolder {
        CheckBox checkBox_bac;
    }
}