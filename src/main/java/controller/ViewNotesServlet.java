package controller;

import java.io.*;
import java.util.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import dao.NoteDAO;
import model.Note;

@WebServlet("/ViewNotesServlet")
public class ViewNotesServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    	response.setHeader("Pragma", "no-cache");
    	response.setDateHeader("Expires", 0);

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
        	response.sendRedirect(request.getContextPath() + "/html/login.html");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        NoteDAO dao = new NoteDAO();
        List<Note> notes = dao.getNotesByUser(userId);

        request.setAttribute("notes", notes);
        request.getRequestDispatcher("/html/viewNotes.jsp").forward(request, response);
    }
}