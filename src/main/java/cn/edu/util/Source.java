package cn.edu.util;

/**
 * Created by Administrator on 2017/6/19.
 */
public class Source {
    private Integer value;
    private String text;

    public Integer getValue() {
        return value;
    }

    public void setValue(Integer value) {
        this.value = value;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public Source(Integer value, String text) {
        this.value = value;
        this.text = text;
    }
}
