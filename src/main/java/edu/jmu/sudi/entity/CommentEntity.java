package edu.jmu.sudi.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 评价实体类
 * @author LiangJie
 */
public class CommentEntity extends OrderDetailEntity implements Serializable {

    private Long commentId;
    private Long userId;
    private String username;
    private BigDecimal commentScore;
    private String commentContent;
    private Date commentTime;

    public Long getCommentId() {
        return commentId;
    }

    public void setCommentId(Long commentId) {
        this.commentId = commentId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public BigDecimal getCommentScore() {
        return commentScore;
    }

    public void setCommentScore(BigDecimal commentScore) {
        this.commentScore = commentScore;
    }

    public String getCommentContent() {
        return commentContent;
    }

    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent;
    }

    public Date getCommentTime() {
        return commentTime;
    }

    public void setCommentTime(Date commentTime) {
        this.commentTime = commentTime;
    }
}
