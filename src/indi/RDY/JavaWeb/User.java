package indi.RDY.JavaWeb;

import java.sql.Date;

public class User {
    private int id;
    private String nickName;
    private String passWord;
    private int type;
    private Date registeredTime;
    //用户类型静态常量
    public static final int USER = 1, OPERATOR = 2, ADMIN = 3;

    public User(int id) {
        this.nickName = null;
        type = User.USER;
    }

    public int getId() {
        return id;
    }

    public int getType() {
        return type;
    }

    public String getNickName() {
        return nickName;
    }

    public String getPassWord() {
        return passWord;
    }

    public Date getRegisteredTime() {
        return registeredTime;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    public void setType(int type) {
        this.type = type;
    }

    public void setRegisteredTime(Date registeredTime) {
        this.registeredTime = registeredTime;
    }

    public void decodePassword() {
        char[] temp = new char[passWord.length()];
        //To use algorithm

        this.passWord = new String(temp);
    }

    public void encodePassword() {
        char[] temp = new char[passWord.length()];
        //To use algorithm

        this.passWord = new String(temp);
    }
}