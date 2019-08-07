package com.sliver.pojo;

import java.util.Date;

public class Board {
    private Integer id;

    private String boardName;

    private String introduce;

    private String pic;

    private Integer userId;

    private Date createtime;

    private Date altertime;

    private Integer orderNum;

    private String username;

    private Date ownerTime;

    private Integer score;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBoardName() {
        return boardName;
    }

    public void setBoardName(String boardName) {
        this.boardName = boardName == null ? null : boardName.trim();
    }

    public String getIntroduce() {
        return introduce;
    }

    public void setIntroduce(String introduce) {
        this.introduce = introduce == null ? null : introduce.trim();
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic == null ? null : pic.trim();
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public Date getAltertime() {
        return altertime;
    }

    public void setAltertime(Date altertime) {
        this.altertime = altertime;
    }

    public Integer getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(Integer orderNum) {
        this.orderNum = orderNum;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public Date getOwnerTime() {
        return ownerTime;
    }

    public void setOwnerTime(Date ownerTime) {
        this.ownerTime = ownerTime;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", boardName=").append(boardName);
        sb.append(", introduce=").append(introduce);
        sb.append(", pic=").append(pic);
        sb.append(", userId=").append(userId);
        sb.append(", createtime=").append(createtime);
        sb.append(", altertime=").append(altertime);
        sb.append(", orderNum=").append(orderNum);
        sb.append(", username=").append(username);
        sb.append(", ownerTime=").append(ownerTime);
        sb.append(", score=").append(score);
        sb.append("]");
        return sb.toString();
    }
}