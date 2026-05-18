package controller;

import java.io.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.NoteDAO;
import model.Note;

@WebServlet("/SearchNoteServlet")
public class SearchNoteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("html/login.html");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String keyword = request.getParameter("keyword");

        NoteDAO dao = new NoteDAO();
        List<Note> notes = dao.searchNotes(userId, keyword);

        request.setAttribute("notes", notes);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("html/viewNotes.jsp").forward(request, response);
    }
}
