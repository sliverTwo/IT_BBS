package com.sliver.pojo;

import java.util.Date;

public class QuestionVo {
    private String id;

    private Integer questionUserId;

    private String title;

    private String question;

    private Integer payScore;

    private Date createtime;

    private Boolean deleted;

    private String usefulAnswerId;

    private Date ackAnswerTime;

    private String username;

        private String pic;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public Integer getQuestionUserId() {
        return questionUserId;
    }

    public void setQuestionUserId(Integer questionUserId) {
        this.questionUserId = questionUserId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question == null ? null : question.trim();
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

    public Date getAckAnswerTime() {
        return ackAnswerTime;
    }

    public void setAckAnswerTime(Date ackAnswerTime) {
        this.ackAnswerTime = ackAnswerTime;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic == null ? null : pic.trim();
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", questionUserId=").append(questionUserId);
        sb.append(", title=").append(title);
        sb.append(", question=").append(question);
        sb.append(", payScore=").append(payScore);
        sb.append(", createtime=").append(createtime);
        sb.append(", deleted=").append(deleted);
        sb.append(", usefulAnswerId=").append(usefulAnswerId);
        sb.append(", ackAnswerTime=").append(ackAnswerTime);
        sb.append(", username=").append(username);
        sb.append(", pic=").append(pic);
        sb.append("]");
        return sb.toString();
    }
}