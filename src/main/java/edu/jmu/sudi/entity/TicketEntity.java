package edu.jmu.sudi.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 优惠券实体类
 * @author LiangJie
 */
public class TicketEntity extends TicketTypeEntity implements Serializable {
    private Long ticketId;
    private Long userId;
    private Date startTime;
    private Date endTime;
    private Integer ticketStatus;
    private String username;

    public Long getTicketId() {
        return ticketId;
    }

    public void setTicketId(Long ticketId) {
        this.ticketId = ticketId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Integer getTicketStatus() {
        return ticketStatus;
    }

    public void setTicketStatus(Integer ticketStatus) {
        this.ticketStatus = ticketStatus;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
