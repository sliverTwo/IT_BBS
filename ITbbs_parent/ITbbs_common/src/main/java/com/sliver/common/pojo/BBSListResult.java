package com.sliver.common.pojo;

import java.io.Serializable;

public class BBSListResult implements Serializable {
    private Long count;
    private  Integer code;
    private  String msg;
    private Object data;
    public BBSListResult(Integer code, String msg, Long count ,Object data) {
        this.code = code;
        this.msg = msg;
        this.count = count;
        this.data = data;
    }
    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public BBSListResult(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public BBSListResult(Integer code, String msg, Object data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    public static BBSListResult ok(Long count, Object data){
        return new BBSListResult(0,null,count,data);
    }
    public static BBSListResult build(Integer code,String msg){
        return  new BBSListResult(code,msg,null,null);
    }

    public Long getCount() {
        return count;
    }

    public void setCount(Long count) {
        this.count = count;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
