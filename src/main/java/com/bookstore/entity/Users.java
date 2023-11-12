package com.bookstore.entity;

import javax.persistence.*;

@Entity
@NamedQueries({
        @NamedQuery(name="Users.findAll",
                query="SELECT u FROM Users u"),
        @NamedQuery(name="Users.findByEmail",
                query="SELECT u FROM Users u WHERE u.email = :email"),
        @NamedQuery(name="Users.countAll",
                query="SELECT COUNT(u) FROM Users u "),
        @NamedQuery(name = "Users.checkLogin",
                query="SELECT u FROM Users u WHERE u.email = :email AND u.password = :password")
})
public class Users {
    private int userId;
    private String email;
    private String password;
    private String fullName;

    public Users() {
    }

    public Users(String email, String password, String fullName) {
        this.email = email;
        this.password = password;
        this.fullName = fullName;
    }

    public Users(int userId, String email, String password, String fullName) {
        this.userId = userId;
        this.email = email;
        this.password = password;
        this.fullName = fullName;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id", nullable = false)
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Basic
    @Column(name = "email", nullable = false, length = 64)
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Basic
    @Column(name = "password", nullable = false, length = 45)
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Basic
    @Column(name = "full_name", nullable = false, length = 64)
    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Users users = (Users) o;

        if (userId != users.userId) return false;
        if (email != null ? !email.equals(users.email) : users.email != null) return false;
        if (password != null ? !password.equals(users.password) : users.password != null) return false;
        if (fullName != null ? !fullName.equals(users.fullName) : users.fullName != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = userId;
        result = 31 * result + (email != null ? email.hashCode() : 0);
        result = 31 * result + (password != null ? password.hashCode() : 0);
        result = 31 * result + (fullName != null ? fullName.hashCode() : 0);
        return result;
    }
}
