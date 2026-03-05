<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <title>Categorie Noua - Studio</title>
    
    <style>
        :root {
            --bg-dark: #000000;
            --bg-panel: rgba(28, 28, 30, 0.75);
            --text-primary: #f5f5f7;
            --text-secondary: #86868b;
            --accent: #bf5af2; /* MOV - Categorii */
            --input-bg: rgba(255, 255, 255, 0.05);
            --border: rgba(255, 255, 255, 0.1);
        }
        * { box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; margin: 0; padding: 0; }
        
        body {
            background-color: var(--bg-dark); color: var(--text-primary);
            min-height: 100vh; display: flex; justify-content: center; align-items: center;
            
            /* LUMINĂ MOV JOS */
            background-image: radial-gradient(circle at 50% 100%, #2d1a36 0%, #000000 70%);
            background-attachment: fixed;
        }

        .form-container {
            width: 100%; max-width: 500px;
            background: var(--bg-panel);
            backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px);
            border: 1px solid var(--border); border-radius: 24px; padding: 40px;
            box-shadow: 0 30px 60px rgba(0,0,0,0.5);
            animation: popIn 0.6s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        h1 { text-align: center; margin-bottom: 30px; font-weight: 700; font-size: 1.8rem; }
        
        label { display: block; margin-bottom: 8px; color: var(--text-secondary); font-size: 0.9rem; margin-top: 15px; }
        
        input[type="text"] {
            width: 100%; padding: 14px;
            background: var(--input-bg); border: 1px solid var(--border); border-radius: 12px;
            color: white; font-size: 1rem; transition: all 0.3s;
        }
        input:focus { border-color: var(--accent); background: black; outline: none; box-shadow: 0 0 0 2px rgba(191, 90, 242, 0.3); }

        input[type="submit"] {
            width: 100%; padding: 16px; background: var(--accent); color: white;
            border: none; border-radius: 12px; font-weight: 600; font-size: 1rem; cursor: pointer;
            transition: transform 0.2s; margin-top: 30px;
        }
        input[type="submit"]:hover { filter: brightness(1.1); transform: scale(1.02); }
        
        .back-link { display: block; text-align: center; margin-top: 20px; color: var(--text-secondary); text-decoration: none; font-size: 0.9rem; transition: color 0.3s; }
        .back-link:hover { color: white; }

        .msg-box { padding: 15px; border-radius: 12px; text-align: center; margin-bottom: 20px; font-weight: 500; }
        .success { background: rgba(191, 90, 242, 0.2); color: #bf5af2; border: 1px solid rgba(191, 90, 242, 0.3); }
        .error { background: rgba(255, 69, 58, 0.2); color: #ff453a; border: 1px solid rgba(255, 69, 58, 0.3); }

        @keyframes popIn { from { opacity: 0; transform: scale(0.9); } to { opacity: 1; transform: scale(1); } }
    </style>
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>

    <div class="form-container">
        <% 
            String nume_categorie = request.getParameter("nume_categorie"); 

            if (nume_categorie != null && !nume_categorie.trim().isEmpty()) { 
                jb.connect(); 
                jb.adaugaCategorie(nume_categorie); 
                jb.disconnect(); 
        %>
            <div class="msg-box success">✨ Categorie adăugată cu succes!</div>
            <a href="tabela_Categorii.jsp" class="back-link">← Înapoi la Tabel</a>
            <a href="nou_Categorii.jsp" class="back-link" style="margin-top: 10px;">+ Adaugă alta</a>
        <% 
            } else { 
        %>
            <h1>Categorie Nouă</h1>
            
            <% if (nume_categorie != null) { %>
                <div class="msg-box error">Eroare: Numele nu poate fi gol!</div>
            <% } %>

            <form action="nou_Categorii.jsp" method="post">
                <label>Nume Gen / Categorie</label>
                <input type="text" name="nume_categorie" placeholder="Ex: Documentar, Thriller..." required autocomplete="off"/>

                <input type="submit" value="Salvează Categoria" />
            </form>
            
            <a href="tabela_Categorii.jsp" class="back-link">Anulează</a>
        <% } %>
    </div>

</body>
</html>