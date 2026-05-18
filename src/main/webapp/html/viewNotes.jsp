<%@ page import="java.util.*, model.Note" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notes Management System</title>
    <style>
        * { margin:0; padding:0; box-sizing:border-box; font-family:'Segoe UI',sans-serif; }
        body { background:#f0f4f8; }
        .navbar { background:#2c3e50; padding:15px 30px; display:flex; justify-content:space-between; align-items:center; }
        .navbar h2 { color:#3498db; font-size:20px; }
        .navbar a { color:white; text-decoration:none; margin-left:12px; background:#3498db; padding:7px 14px; border-radius:6px; font-size:14px; }
        .navbar a:hover { background:#2980b9; }
        .container { max-width:1100px; margin:30px auto; padding:0 20px; }
        .top-bar { display:flex; justify-content:space-between; align-items:center; margin-bottom:20px; }
        .top-bar h2 { color:#2c3e50; font-size:24px; }
        .add-btn { background:#27ae60; color:white; padding:10px 20px; border-radius:8px; text-decoration:none; font-size:14px; }
        .add-btn:hover { background:#219a52; }
        .search-bar { display:flex; gap:10px; margin-bottom:25px; }
        .search-bar input { flex:1; padding:10px 15px; border:1.5px solid #ddd; border-radius:8px; font-size:14px; }
        .search-bar input:focus { outline:none; border-color:#3498db; }
        .search-btn { background:#3498db; color:white; padding:10px 20px; border:none; border-radius:8px; cursor:pointer; font-size:14px; }
        .clear-btn { background:#95a5a6; color:white; padding:10px 15px; border-radius:8px; text-decoration:none; font-size:14px; }
        .no-notes { text-align:center; padding:60px; color:#999; font-size:16px; background:white; border-radius:12px; }
        table { width:100%; border-collapse:collapse; background:white; border-radius:12px; overflow:hidden; box-shadow:0 2px 15px rgba(0,0,0,0.08); }
        thead { background:#2c3e50; color:white; }
        th { padding:14px 16px; text-align:center; font-size:14px; font-weight:500; }
        td { padding:13px 16px; font-size:14px; color:#444; border-bottom:1px solid #f0f0f0;}
        tbody tr:hover { background:#f8f9fa; transition:background 0.2s; }
        .edit-btn { background:#f39c12; color:white; padding:6px 12px; border-radius:5px; text-decoration:none; font-size:12px; }
        .edit-btn:hover { background:#e67e22; }
        .del-btn { background:#e74c3c; color:white; padding:6px 12px; border-radius:5px; text-decoration:none; font-size:12px; border:none; cursor:pointer; }
        .del-btn:hover { background:#c0392b; }
        .view-btn { background:#8e44ad; color:white; padding:6px 12px; border-radius:5px; font-size:12px; border:none; cursor:pointer;}
		.view-btn:hover { background:#7d3c98; }
		.pdf-btn { background:#27ae60; color:white; padding:6px 12px; border-radius:5px; font-size:12px; border:none; cursor:pointer;}
			.pdf-btn:hover { background:#219a52; }

        /* Delete Modal */
        .modal-overlay { display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:999; justify-content:center; align-items:center; }
        .modal-overlay.show { display:flex; }
        .modal-box { background:white; border-radius:16px; padding:40px; text-align:center; box-shadow:0 10px 40px rgba(0,0,0,0.2); max-width:350px; width:90%; animation:popIn 0.3s ease; }
        @keyframes popIn { from { transform:scale(0.7); opacity:0; } to { transform:scale(1); opacity:1; } }
        .modal-icon { font-size:55px; margin-bottom:15px; }
        .modal-title { font-size:20px; font-weight:600; color:#2c3e50; margin-bottom:8px; }
        .modal-msg { color:#666; font-size:14px; margin-bottom:25px; }
        .modal-btns { display:flex; gap:10px; justify-content:center; }
        .confirm-btn { background:#e74c3c; color:white; border:none; padding:10px 25px; border-radius:8px; font-size:14px; cursor:pointer; }
        .cancel-btn { background:#2c3e50; color:white; border:none; padding:10px 25px; border-radius:8px; font-size:14px; cursor:pointer; }
        
        
        button svg, a svg{ transition: 0.3s; }
		button:hover svg, a:hover svg{
    		transform: scale(1.15);
		}

    </style>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
</head>
<body>

<div class="navbar">
    <h2>📝 Notes Management System</h2>
    <div>
        <a href="/SmartNotesManagmentSystem/html/dashboard.html">My Notes</a>
        <a href="/SmartNotesManagmentSystem/html/dashboard.html">Dashboard</a>
        <a href="/SmartNotesManagmentSystem/LogoutServlet">Logout</a>
    </div>
</div>

<div class="container">
    <div class="top-bar">
        <h2>📋 My Notes</h2>
         <a href="/SmartNotesManagmentSystem/html/addNote.html" class="add-btn">+ Add Note</a>
    </div>

    <form action="/SmartNotesManagmentSystem/SearchNoteServlet" method="get" class="search-bar">
        <input type="text" name="keyword" placeholder="🔍 Search Notes...." value="${keyword}">
        <button type="submit" class="search-btn">Search</button>
        <a href="/SmartNotesManagmentSystem/ViewNotesServlet" class="clear-btn">Clear</a>
    </form>

    <%
        List<Note> notes = (List<Note>) request.getAttribute("notes");
        if (notes == null || notes.isEmpty()) {
    %>
        <div class="no-notes">
            <p>📭 No notes found!</p>
            <a href="/SmartNotesManagmentSystem/html/addNote.html" style="color:#3498db; margin-top:10px; display:inline-block;">+ Add your first note.

</a>
        </div>
    <%
        } else {
    %>
    <table>
        <thead>
            <tr>
                <th>S/N</th>
                <th>Subject</th>
                <th>Title</th>
                <th>Content</th>
                <th>Date</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            int i = 1;
            for (Note note : notes) {
        %>
            <tr>
                <td><%= i++ %></td>
                <td><%= note.getSubject() %></td>
                <td><%= note.getTitle() %></td>
                <td><%= note.getContent().length() > 50 ? note.getContent().substring(0, 50) + "..." : note.getContent() %></td>
                <td><%= note.getCreatedAt().toString().substring(0, 10) %></td>
               
                <td>
                	<button class="view-btn" data-subject="<%= note.getSubject() %>" data-title="<%= note.getTitle() %>" data-content="<%= note.getContent() %>"
    					data-date="<%= note.getCreatedAt().toString().substring(0,10) %>" onclick="showViewModal(this)">
    						<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="white" viewBox="0 0 24 24" style="vertical-align:middle; margin-right:3px;"><path d="M12 4.5C7 4.5 2.73 7.61 1 12c1.73 4.39 6 7.5 11 7.5s9.27-3.11 11-7.5c-1.73-4.39-6-7.5-11-7.5zm0 12.5a5 5 0 1 1 0-10 5 5 0 0 1 0 10zm0-8a3 3 0 1 0 0 6 3 3 0 0 0 0-6z"/></svg>
   									 View
					</button>
    					                 
					<a href="/SmartNotesManagmentSystem/EditNoteServlet?id=<%= note.getId() %>" class="edit-btn">✏️ Edit</a>
                    <button class="del-btn" onclick="showDeleteModal(<%= note.getId() %>)">🗑️ Delete</button>
                    <button class="pdf-btn" data-subject="<%= note.getSubject() %>" data-title="<%= note.getTitle() %>"
   							 data-content="<%= note.getContent() %>"
    						data-date="<%= note.getCreatedAt().toString().substring(0,10) %>"
    						onclick="downloadPDF(this)">
    					<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="white" viewBox="0 0 24 24" style="vertical-align:middle; margin-right:3px;"><path d="M19 9h-4V3H9v6H5l7 7 7-7zm-8 2V5h2v6h1.17L12 13.17 9.83 11H11zm-6 7h14v2H5v-2z"/></svg>
    								PDF
					</button>
                </td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <%
        }
    %>
</div>


<div class="modal-overlay" id="viewModal">
    <div class="modal-box" style="max-width:750px; text-align:left;">
        <div style="text-align:center; font-size:50px; margin-bottom:10px;">📋</div>
        <div style="text-align:center; font-size:20px; font-weight:600; color:#2c3e50; margin-bottom:20px;" id="viewTitle"></div>
        <div style="margin-bottom:12px;">
            <p style="font-size:12px; color:#00000; margin-bottom:3px;">SUBJECT</p>
            <p style="background:#f8f9fa; padding:8px 12px; border-radius:6px; color:#2c3e50; font-weight:600;" id="viewSubject"></p>
        </div>
        <div style="margin-bottom:12px;">
            <p style="font-size:12px; color:#00000; margin-bottom:3px;">CONTENT</p>
            <p style="background:#f8f9fa; padding:8px 12px; border-radius:6px; color:#444; line-height:1.7;" id="viewContent"></p>
        </div>
        <div style="margin-bottom:20px;">
            <p style="font-size:12px; color:#00000; margin-bottom:3px;">DATE</p>
            <p style="background:#f8f9fa; padding:8px 12px; border-radius:6px; color:#444;" id="viewDate"></p>
        </div>
        <button class="cancel-btn" onclick="closeViewModal()" style="width:100%; padding:12px;">Close</button>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal-overlay" id="deleteModal">
    <div class="modal-box">
        <div class="modal-icon">🗑️</div>
       <div class="modal-title">Delete Note?</div>
		<div class="modal-msg">This note will be permanently deleted. <br>
		 Are you sure?</div>
        <div class="modal-btns">
            <button class="cancel-btn" onclick="closeModal()">Cancel</button>
            <button class="confirm-btn" id="confirmDelete">Delete</button>
        </div>
    </div>
</div>

<!-- Update Success Modal -->
<div class="modal-overlay" id="updateModal">
    <div class="modal-box">
        <div class="modal-icon">✅</div>
        <div class="modal-title">Note Updated!</div>
        <button class="modal-btn" style="background:#3498db; color:white; border:none; padding:12px 35px; border-radius:8px; font-size:14px; cursor:pointer; width:100%;" onclick="closeUpdateModal()">OK</button>
    </div>
</div>

<script>

function showViewModal(btn) {
    document.getElementById('viewSubject').innerText = btn.getAttribute('data-subject');
    document.getElementById('viewTitle').innerText = btn.getAttribute('data-title');
    document.getElementById('viewContent').innerText = btn.getAttribute('data-content');
    document.getElementById('viewDate').innerText = btn.getAttribute('data-date');
    document.getElementById('viewModal').classList.add('show');
}

function closeViewModal() {
    document.getElementById('viewModal').classList.remove('show');
}

function downloadPDF(btn) {
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF();

    const subject = btn.getAttribute('data-subject');
    const title = btn.getAttribute('data-title');
    const content = btn.getAttribute('data-content');
    const date = btn.getAttribute('data-date');

    // Header background
    doc.setFillColor(44, 62, 80);
    doc.rect(0, 0, 210, 30, 'F');

    // Header text
    doc.setTextColor(255, 255, 255);
    doc.setFontSize(18);
    doc.setFont('helvetica', 'bold');
    doc.text('Smart Notes Manager', 14, 18);

    // Title
    doc.setTextColor(44, 62, 80);
    doc.setFontSize(20);
    doc.setFont('helvetica', 'bold');
    doc.text(title, 14, 50);

    // Subject
    doc.setFillColor(240, 244, 248);
    doc.rect(14, 58, 182, 10, 'F');
    doc.setFontSize(11);
    doc.setFont('helvetica', 'normal');
    doc.setTextColor(100, 100, 100);
    doc.text('Subject: ' + subject, 18, 65);

    // Date
    doc.setFontSize(11);
    doc.setTextColor(100, 100, 100);
    doc.text('Date: ' + date, 18, 80);

    // Divider line
    doc.setDrawColor(52, 152, 219);
    doc.setLineWidth(0.5);
    doc.line(14, 85, 196, 85);

    // Content heading
    doc.setFontSize(13);
    doc.setFont('helvetica', 'bold');
    doc.setTextColor(44, 62, 80);
    doc.text('Content:', 14, 95);

    // Content text
    doc.setFontSize(12);
    doc.setFont('helvetica', 'normal');
    doc.setTextColor(60, 60, 60);
    const lines = doc.splitTextToSize(content, 180);
    doc.text(lines, 14, 105);

    // Footer
    doc.setFillColor(44, 62, 80);
    doc.rect(0, 282, 210, 15, 'F');
    doc.setTextColor(255, 255, 255);
    doc.setFontSize(9);
    doc.text('Generated by Smart Notes Manager', 14, 291);
    doc.text(date, 170, 291);

    doc.save(title + '.pdf');
}


    let deleteId = null;

    function showDeleteModal(id) {
        deleteId = id;
        document.getElementById('deleteModal').classList.add('show');
    }

    function closeModal() {
        document.getElementById('deleteModal').classList.remove('show');
        deleteId = null;
    }

    document.getElementById('confirmDelete').addEventListener('click', function() {
        if (deleteId) {
            window.location.href = '/SmartNotesManagmentSystem/DeleteNoteServlet?id=' + deleteId;
        }
    });
    
    
 // Update success modal
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('msg') === 'success') {
        document.getElementById('updateModal').classList.add('show');
    }

    function closeUpdateModal() {
        document.getElementById('updateModal').classList.remove('show');
        window.history.replaceState({}, document.title, window.location.pathname);
    }
</script>

</body>
</html>