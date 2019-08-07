package com.sliver.pojo;

import java.util.Date;

public class Question {
    private String id;

    private Integer userId;

    private String title;

    private String content;

    private Integer payScore;

    private Date createtime;

    private Boolean deleted;

    private String usefulAnswerId;

    private String username;

    private Date ackAnswerTime;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public Integer getPayScore() {
        return payScore;
    }

    public void setPayScore(Integer payScore) {
        this.payScore = payScore;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public Boolean getDeleted() {
        return deleted;
    }

    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }

    public String getUsefulAnswerId() {
        return usefulAnswerId;
    }

    public void setUsefulAnswerId(String usefulAnswerId) {
        this.usefulAnswerId = usefulAnswerId == null ? null : usefulAnswerId.trim();
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public Date getAckAnswerTime() {
        return ackAnswerTime;
    }

    public void setAckAnswerTime(Date ackAnswerTime) {
        this.ackAnswerTime = ackAnswerTime;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", userId=").append(userId);
        sb.append(", title=").append(title);
        sb.append(", content=").append(content);
        sb.append(", payScore=").append(payScore);
        sb.append(", createtime=").append(createtime);
        sb.append(", deleted=").append(deleted);
        sb.append(", usefulAnswerId=").append(usefulAnswerId);
        sb.append(", username=").append(username);
        sb.append(", ackAnswerTime=").append(ackAnswerTime);
        sb.append("]");
        return sb.toString();
    }
}