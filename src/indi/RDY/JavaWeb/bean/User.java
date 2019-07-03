package indi.RDY.JavaWeb.bean;

import java.sql.Timestamp;
import java.util.Vector;

public class User {
    private int id;
    private String nickName;
    private String passWord;
    private int type;
    private Timestamp registeredTime;
    //用户类型静态常量
    public static final int VISITOR = 1, USER = 2, OPERATOR = 3, ADMIN = 4;

    public User() {
        type = VISITOR;
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

    public Timestamp getRegisteredTime() {
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

    public void setRegisteredTime(Timestamp registeredTime) {
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