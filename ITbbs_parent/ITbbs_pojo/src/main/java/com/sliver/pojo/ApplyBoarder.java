package com.sliver.pojo;

import java.util.Date;

public class ApplyBoarder {
    private Integer id;

    private Integer userId;

    private String username;

    private Integer boardId;

    private String boardName;

    private String applyReason;

    private Boolean deal;

    private Date createtime;

    private Date dealTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public Integer getBoardId() {
        return boardId;
    }

    public void setBoardId(Integer boardId) {
        this.boardId = boardId;
    }

    public String getBoardName() {
        return boardName;
    }

    public void setBoardName(String boardName) {
        this.boardName = boardName == null ? null : boardName.trim();
    }

    public String getApplyReason() {
        return applyReason;
    }

    public void setApplyReason(String applyReason) {
        this.applyReason = applyReason == null ? null : applyReason.trim();
    }

    public Boolean getDeal() {
        return deal;
    }

    public void setDeal(Boolean deal) {
        this.deal = deal;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public Date getDealTime() {
        return dealTime;
    }

    public void setDealTime(Date dealTime) {
        this.dealTime = dealTime;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", userId=").append(userId);
        sb.append(", username=").append(username);
        sb.append(", boardId=").append(boardId);
        sb.append(", boardName=").append(boardName);
        sb.append(", applyReason=").append(applyReason);
        sb.append(", deal=").append(deal);
        sb.append(", createtime=").append(createtime);
        sb.append(", dealTime=").append(dealTime);
        sb.append("]");
        return sb.toString();
    }
}