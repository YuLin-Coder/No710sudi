package edu.jmu.sudi.utils;

/**
 * LayUI模板引擎
 * @author LiangJie
 */
public class TemplateUtil {

    private String title;
    private Object list;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Object getList() {
        return list;
    }

    public void setList(Object list) {
        this.list = list;
    }

    public TemplateUtil(String title, Object list) {
        this.title = title;
        this.list = list;
    }

    public TemplateUtil(Object list) {
        this.list = list;
    }
}
