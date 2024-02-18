package com.workmotion.app.chat.model;

import java.util.Date;

public class RoomInfoDTO {
    private Long member_id;
    private String room_name;
    private Date join_dt;
    private Date recently_dt;

    public Long getMember_id() {
        return member_id;
    }

    public void setMember_id(Long member_id) {
        this.member_id = member_id;
    }

    public String getRoom_name() {
        return room_name;
    }

    public void setRoom_name(String room_name) {
        this.room_name = room_name;
    }

    public Date getJoin_dt() {
        return join_dt;
    }

    public void setJoin_dt(Date join_dt) {
        this.join_dt = join_dt;
    }

    public Date getRecently_dt() {
        return recently_dt;
    }

    public void setRecently_dt(Date recently_dt) {
        this.recently_dt = recently_dt;
    }
}