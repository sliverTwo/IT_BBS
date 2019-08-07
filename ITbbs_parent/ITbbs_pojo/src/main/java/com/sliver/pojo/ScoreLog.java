package com.sliver.pojo;

import java.util.Date;

public class ScoreLog {
    private String id;

    private Integer userId;

    private String content;

    private Integer score;

    private Date createtime;

    public ScoreLog() {
    }

    public ScoreLog(String id, Integer userId, String content, Integer score, Date createtime) {
        this.id = id;
        this.userId = userId;
        this.content = content;
        this.score = score;
        this.createtime = createtime;
    }

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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", userId=").append(userId);
        sb.append(", content=").append(content);
        sb.append(", score=").append(score);
        sb.append(", createtime=").append(createtime);
        sb.append("]");
        return sb.toString();
    }
}