package dao;

import java.sql.*;
import java.util.*;
import model.Note;
import Util.JDBConnection;

public class NoteDAO {

    // Note add karo
    public boolean addNote(Note note) {
        try {
            Connection con = JDBConnection.getConnection();
            String sql = "INSERT INTO notes (user_id, subject, title, content) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, note.getUserId());
            ps.setString(2, note.getSubject());
            ps.setString(3, note.getTitle());
            ps.setString(4, note.getContent());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    
    public List<Note> getNotesByUser(int userId) {
        List<Note> list = new ArrayList<>();
        try {
            Connection con = JDBConnection.getConnection();
            String sql = "SELECT * FROM notes WHERE user_id=? ORDER BY created_at DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Note n = new Note();
                n.setId(rs.getInt("id"));
                n.setUserId(rs.getInt("user_id"));
                n.setSubject(rs.getString("subject"));
                n.setTitle(rs.getString("title"));
                n.setContent(rs.getString("content"));
                n.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(n);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    
    public boolean deleteNote(int noteId) {
        try {
            Connection con = JDBConnection.getConnection();
            String sql = "DELETE FROM notes WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, noteId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

   
    public boolean updateNote(Note note) {
        try {
            Connection con = JDBConnection.getConnection();
            String sql = "UPDATE notes SET subject=?, title=?, content=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, note.getSubject());
            ps.setString(2, note.getTitle());
            ps.setString(3, note.getContent());
            ps.setInt(4, note.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ID ne ek note ghe (edit sathi)
    public Note getNoteById(int noteId) {
        try {
            Connection con = JDBConnection.getConnection();
            String sql = "SELECT * FROM notes WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, noteId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Note n = new Note();
                n.setId(rs.getInt("id"));
                n.setUserId(rs.getInt("user_id"));
                n.setSubject(rs.getString("subject"));
                n.setTitle(rs.getString("title"));
                n.setContent(rs.getString("content"));
                n.setCreatedAt(rs.getTimestamp("created_at"));
                return n;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Search notes
    public List<Note> searchNotes(int userId, String keyword) {
        List<Note> list = new ArrayList<>();
        try {
            Connection con = JDBConnection.getConnection();
            String sql = "SELECT * FROM notes WHERE user_id=? AND (subject LIKE ? OR title LIKE ? OR content LIKE ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, "%" + keyword + "%");
            ps.setString(3, "%" + keyword + "%");
            ps.setString(4, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Note n = new Note();
                n.setId(rs.getInt("id"));
                n.setUserId(rs.getInt("user_id"));
                n.setSubject(rs.getString("subject"));
                n.setTitle(rs.getString("title"));
                n.setContent(rs.getString("content"));
                n.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(n);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
