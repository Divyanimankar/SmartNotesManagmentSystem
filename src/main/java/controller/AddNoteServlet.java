package controller;

import java.io.IOException;
import dao.NoteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Note;

@WebServlet("/AddNoteServlet")
public class AddNoteServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("html/login.html");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String subject = request.getParameter("subject");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        Note note = new Note();
        note.setUserId(userId);
        note.setSubject(subject);
        note.setTitle(title);
        note.setContent(content);

        NoteDAO dao = new NoteDAO();
        boolean success = dao.addNote(note);

        if (success) {
        	response.sendRedirect(request.getContextPath() + "/html/addNote.html?msg=success");
        } else {
            response.sendRedirect("html/addNote.html?msg=error");
        }
    }
}
