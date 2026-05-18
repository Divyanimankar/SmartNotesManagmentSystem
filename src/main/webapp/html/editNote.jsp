<%@ page import="model.Note" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Note - Smart Notes Manager</title>
    <link rel="stylesheet" href="/SmartNotesManagmentSystem/css/style.css">
    <style>
        .container { max-width:550px; margin:50px auto; background:white; padding:40px; border-radius:16px; box-shadow:0 4px 25px rgba(0,0,0,0.1); }
        .container h2 { color:#2c3e50; margin-bottom:25px; font-size:24px; }
        label { display:block; margin-bottom:6px; color:#555; font-weight:600; font-size:14px; }
        input[type="text"], textarea { width:100%; padding:12px; margin-bottom:18px; border:1.5px solid #ddd; border-radius:8px; font-size:14px; transition:border-color 0.3s; }
        input[type="text"]:focus, textarea:focus { outline:none; border-color:#3498db; }
        textarea { height:130px; resize:vertical; }
        .btn-update { width:100%; padding:13px; background:#f39c12; color:white; border:none; border-radius:8px; font-size:16px; cursor:pointer; font-weight:600; transition:background 0.3s; }
        .btn-update:hover { background:#e67e22; }
        .btn-cancel { display:block; text-align:center; margin-top:12px; color:#FFFF; background:#2c3e50; text-decoration:none; font-size:14px; padding: 10px }
        .btn-cancel:hover { color:#7f8c8d; }
        .navbar { background:#2c3e50; padding:15px 30px; display:flex; justify-content:space-between; align-items:center; }
        .navbar h2 { color:#3498db; font-size:20px; }
        .navbar a { color:white; text-decoration:none; margin-left:12px; background:#3498db; padding:7px 14px; border-radius:6px; font-size:14px; }
        .navbar a:hover { background:#2980b9; }

        /* Success Modal */
        .modal-overlay { display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:999; justify-content:center; align-items:center; }
        .modal-overlay.show { display:flex; }
        .modal-box { background:white; border-radius:16px; padding:40px; text-align:center; box-shadow:0 10px 40px rgba(0,0,0,0.2); max-width:350px; width:90%; animation:popIn 0.3s ease; }
        @keyframes popIn { from { transform:scale(0.7); opacity:0; } to { transform:scale(1); opacity:1; } }
        .modal-icon { font-size:55px; margin-bottom:15px; }
        .modal-title { font-size:20px; font-weight:600; color:#2c3e50; margin-bottom:8px; }
        .modal-msg { color:#666; font-size:14px; margin-bottom:25px; }
        .modal-btn { background:#3498db; color:white; border:none; padding:12px 35px; border-radius:8px; font-size:14px; cursor:pointer; width:100%; }
    </style>
</head>
<body>

<% Note note = (Note) request.getAttribute("note"); %>

<div class="navbar">
    <h2>📝 Notes Management System</h2>
    <div>
        <a href="/SmartNotesManagmentSystem/ViewNotesServlet">My Notes</a>
        <a href="/SmartNotesManagmentSystem/html/dashboard.html">Dashboard</a>
        <a href="/SmartNotesManagmentSystem/LogoutServlet">Logout</a>
    </div>
</div>

<div class="container">
    <h2>✏️ Edit Note</h2>

    <form action="/SmartNotesManagmentSystem/EditNoteServlet" method="post">
        <input type="hidden" name="id" value="<%= note.getId() %>">

        <label>Subject</label>
        <input type="text" name="subject" value="<%= note.getSubject() %>" required>

        <label>Title</label>
        <input type="text" name="title" value="<%= note.getTitle() %>" required>

        <label>Content</label>
        <textarea name="content" required><%= note.getContent() %></textarea>

        <button type="submit" class="btn-update">Update Note</button>
    </form>

    <a href="/SmartNotesManagmentSystem/ViewNotesServlet" class="btn-cancel">← Cancel</a>
</div>

<!-- Success Modal -->
<div class="modal-overlay" id="successModal">
    <div class="modal-box">
        <div class="modal-icon">✅</div>
        <div class="modal-title">Note Updated!</div>
        <div class="modal-msg">Tumchi note successfully update zali!</div>
        <button class="modal-btn" onclick="goToNotes()">OK</button>
    </div>
</div>

<script>
    function goToNotes() {
        window.location.href = '/SmartNotesManagmentSystem/ViewNotesServlet';
    }

    const params = new URLSearchParams(window.location.search);
    if (params.get('msg') === 'success') {
        document.getElementById('successModal').classList.add('show');
        setTimeout(goToNotes, 3000);
    }
</script>

</body>
</html>