package cn.edu.util.jstree;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/6/23.
 */
public class TreeNode {
    private String id;
    private String parent;
    private String text;
    private String icon;
    private Map<String,Object>state=new HashMap<String,Object>();
    private Map<String,Object>li_attr=new HashMap<String,Object>();
    private Map<String,Object> a_attr=new HashMap<String,Object>();

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getParent() {
        return parent;
    }

    public void setParent(String parent) {
        this.parent = parent;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public Map<String, Object> getState() {
        return state;
    }

    public void setState(Map<String, Object> state) {
        this.state = state;
    }

    public Map<String, Object> getLi_attr() {
        return li_attr;
    }

    public void setLi_attr(Map<String, Object> li_attr) {
        this.li_attr = li_attr;
    }

    public Map<String, Object> getA_attr() {
        return a_attr;
    }

    public void setA_attr(Map<String, Object> a_attr) {
        this.a_attr = a_attr;
    }

}
