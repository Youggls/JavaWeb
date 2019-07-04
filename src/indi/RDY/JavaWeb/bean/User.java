package indi.RDY.JavaWeb.bean;

import java.sql.Timestamp;
import java.util.Vector;

public class User {
    private int id;
    private String nickName;
    private String passWord;
    private String photoUrl;
    private int type;
    private Timestamp registeredTime;
    //用户类型静态常量
    public static final int VISITOR = 1, USER = 2, OPERATOR = 3, ADMIN = 4;

    public User() {
        type = VISITOR;
    }

    public User(int id, String nickName, String passWord, String photoUrl, int type, Timestamp registeredTime) {
        this(id, nickName, photoUrl, type, registeredTime);
        this.passWord = passWord;
    }

    public User(int id, String nickName, String photoUrl, int type, Timestamp registeredTime) {
        this.id = id;
        this.nickName = nickName;
        this.type = type;
        this.registeredTime = registeredTime;
        this.photoUrl = photoUrl;
        this.passWord = null;
    }

    public static int phraseType(String type) {
        switch (type) {
            case "visitor":
                return VISITOR;
            case "user":
                return USER;
            case "operator":
                return OPERATOR;
            case "admin":
                return ADMIN;
            default:
                return VISITOR;
        }
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

    public String getPhotoUrl() {
        return photoUrl;
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

    public void setPhotoUrl(String photoUrl) {
        this.photoUrl = photoUrl;
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