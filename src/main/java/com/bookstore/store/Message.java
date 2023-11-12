package com.bookstore.store;

public class Message {
    private String title;
    private String msg;
    private String status;
    private String bgColor;

    public Message(String title, String msg, String status) {
        this.title = title;
        this.msg = msg;
        this.status = status;
        if(status.equals("success")) {
            this.bgColor = "bg-" + status;
        } else if(status.equals("error")) {
            this.bgColor="bg-" +"danger";
        }
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getBgColor() {
        return bgColor;
    }

    public void setBgColor(String bgColor) {
        this.bgColor = bgColor;
    }

}
