package indi.RDY.JavaWeb.bean;

import java.sql.Timestamp;
import java.util.TooManyListenersException;
import java.util.Vector;

public class User {
    private int id;
    private String nickName;
    private String passWord;
    private String photoUrl;
    private int type;
    private Timestamp registeredTime;
    private String email;
    private String address;
    private String gender;
    private String phone;
    private int follower;
    private int following;
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
        email = "";
        address = "";
        gender = "";
        follower = 0;
        follower = 0;
    }

    public User(int id, String nickName, String photoUrl, Timestamp registeredTime, int type, String gender, String address, String email, String phone, int follower, int following) {
        this(id, nickName, photoUrl, type, registeredTime);
        this.gender = gender;
        this.address = address;
        this.email = email;
        this.phone = phone;
        this.follower = follower;
        this.following = following;
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

    public int getFollower() {
        return follower;
    }

    public String getAddress() {
        return address;
    }

    public String getEmail() {
        return email;
    }

    public String getGender() {
        return gender;
    }

    public String getPhone() {
        return phone;
    }

    public int getFollowing() {
        return following;
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

    public void setAddress(String address) {
        this.address = address;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public void setFollower(int follower) {
        this.follower = follower;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setFollowing(int following) {
        this.following = following;
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