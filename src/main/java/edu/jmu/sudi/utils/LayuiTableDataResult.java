package edu.jmu.sudi.utils;

/**
 * LayUI数据表格类
 * 用于转换Layui的数据表格类所需要的json格式参数
 */
public class LayuiTableDataResult {
    //执行状态码
    private Integer code = 0;
    //提示信息
    private String msg = "";
    //数据总数量
    private Long count = 0L;
    //数据集合列表
    private Object data;

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Long getCount() {
        return count;
    }

    public void setCount(Long count) {
        this.count = count;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public LayuiTableDataResult(Object data) {
        this.data = data;
    }

    public LayuiTableDataResult(Long count, Object data) {
        this.count = count;
        this.data = data;
    }
}
