package controller;

import java.io.*;
import dao.NoteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/DeleteNoteServlet")
public class DeleteNoteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("html/login.html");
            return;
        }

        int noteId = Integer.parseInt(request.getParameter("id"));
        NoteDAO dao = new NoteDAO();
        dao.deleteNote(noteId);

        response.sendRedirect("ViewNotesServlet");
    }
}
