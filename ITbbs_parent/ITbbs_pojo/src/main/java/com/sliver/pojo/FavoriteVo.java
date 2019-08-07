package com.sliver.pojo;

import java.util.Date;

public class FavoriteVo {
    private String id;

    private Date createtime;

    private String userName;

    private String boardName;

    private String title;

    private Integer postUserId;

    private Date favoriteTime;

    private String postId;

    private Date altertime;

    private Integer viewNum;

    private Integer favoriteUserId;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    public String getBoardName() {
        return boardName;
    }

    public void setBoardName(String boardName) {
        this.boardName = boardName == null ? null : boardName.trim();
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public Integer getPostUserId() {
        return postUserId;
    }

    public void setPostUserId(Integer postUserId) {
        this.postUserId = postUserId;
    }

    public Date getFavoriteTime() {
        return favoriteTime;
    }

    public void setFavoriteTime(Date favoriteTime) {
        this.favoriteTime = favoriteTime;
    }

    public String getPostId() {
        return postId;
    }

    public void setPostId(String postId) {
        this.postId = postId == null ? null : postId.trim();
    }

    public Date getAltertime() {
        return altertime;
    }

    public void setAltertime(Date altertime) {
        this.altertime = altertime;
    }

    public Integer getViewNum() {
        return viewNum;
    }

    public void setViewNum(Integer viewNum) {
        this.viewNum = viewNum;
    }

    public Integer getFavoriteUserId() {
        return favoriteUserId;
    }

    public void setFavoriteUserId(Integer favoriteUserId) {
        this.favoriteUserId = favoriteUserId;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", createtime=").append(createtime);
        sb.append(", userName=").append(userName);
        sb.append(", boardName=").append(boardName);
        sb.append(", title=").append(title);
        sb.append(", postUserId=").append(postUserId);
        sb.append(", favoriteTime=").append(favoriteTime);
        sb.append(", postId=").append(postId);
        sb.append(", altertime=").append(altertime);
        sb.append(", viewNum=").append(viewNum);
        sb.append(", favoriteUserId=").append(favoriteUserId);
        sb.append("]");
        return sb.toString();
    }
}