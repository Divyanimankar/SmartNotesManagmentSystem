package controller;

import java.io.*;
import dao.NoteDAO;
import model.Note;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/EditNoteServlet")
public class EditNoteServlet extends HttpServlet {

    // Edit form dikhva (GET)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("html/login.html");
            return;
        }

        int noteId = Integer.parseInt(request.getParameter("id"));
        NoteDAO dao = new NoteDAO();
        Note note = dao.getNoteById(noteId);

        request.setAttribute("note", note);
        request.getRequestDispatcher("html/editNote.jsp").forward(request, response);
    }

    // Update submit (POST)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int noteId = Integer.parseInt(request.getParameter("id"));
        String subject = request.getParameter("subject");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        Note note = new Note();
        note.setId(noteId);
        note.setSubject(subject);
        note.setTitle(title);
        note.setContent(content);

        NoteDAO dao = new NoteDAO();
        dao.updateNote(note);

        response.sendRedirect(request.getContextPath() + "/ViewNotesServlet?msg=success");

    }
}
