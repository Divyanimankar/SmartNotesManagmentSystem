package model;

import java.sql.Timestamp;

public class Note {
    private int id;
    private int userId;
    private String subject;
    private String title;
    private String content;
    private Timestamp createdAt;

    public Note() {}

    public Note(int id, int userId, String subject, String title, String content, Timestamp createdAt) {
        this.id = id;
        this.userId = userId;
        this.subject = subject;
        this.title = title;
        this.content = content;
        this.createdAt = createdAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
