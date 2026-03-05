<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <title>Stergere Categorie</title>
    <style>
        :root {
            --bg-dark: #000000;
            --bg-panel: rgba(28, 28, 30, 0.75);
            --text-primary: #f5f5f7;
            --text-secondary: #86868b;
            --accent: #bf5af2;
            --border: rgba(255, 255, 255, 0.1);
        }

        body {
            background-color: var(--bg-dark);
            color: var(--text-primary);
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background-image: radial-gradient(circle at 50% 100%, #2d1a36 0%, #000000 70%);
        }

        .card {
            background: var(--bg-panel);
            backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px);
            border: 1px solid var(--border);
            border-radius: 24px;
            padding: 40px;
            text-align: center;
            max-width: 450px;
            width: 90%;
            box-shadow: 0 20px 50px rgba(0,0,0,0.5);
            animation: popIn 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        .icon { font-size: 3rem; margin-bottom: 20px; }
        h1 { font-size: 1.5rem; margin-bottom: 10px; }
        p { color: var(--text-secondary); margin-bottom: 30px; line-height: 1.5; }

        .btn {
            display: inline-block;
            background: white;
            color: black;
            padding: 12px 30px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            transition: transform 0.2s;
        }
        .btn:hover { transform: scale(1.05); }

        @keyframes popIn { from { opacity: 0; transform: scale(0.9); } to { opacity: 1; transform: scale(1); } }
    </style>
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>

    <div class="card">
        <% 
            String[] s = request.getParameterValues("primarykey"); 
            
            if (s != null && s.length > 0) {
                jb.connect(); 
                jb.stergeDateTabela(s, "categorii", "id_categorie"); 
                jb.disconnect(); 
        %>
            <div class="icon">🗑️</div>
            <h1>Categorie Ștearsă</h1>
            <p>Categoriile selectate au fost eliminate.</p>
        <% 
            } else { 
        %>
            <div class="icon">⚠️</div>
            <h1>Nimic selectat</h1>
            <p>Te rog selectează cel puțin o categorie pentru a o șterge.</p>
        <% 
            } 
        %>
        
        <a href="tabela_Categorii.jsp" class="btn">Înapoi la Tabel</a>
    </div>

</body>
</html>