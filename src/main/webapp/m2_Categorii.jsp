<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modificare Reușită</title>

    <style>
        :root {
            --bg-dark: #000000;
            --bg-panel: rgba(28, 28, 30, 0.75);
            --text-primary: #f5f5f7;
            --text-secondary: #86868b;
            --accent: #bf5af2; /* MOV - Specific Categorii */
            --border: rgba(255, 255, 255, 0.1);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; }

        body {
            background-color: var(--bg-dark);
            color: var(--text-primary);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            /* Gradient Mov Jos */
            background-image: radial-gradient(circle at 50% 100%, #2d1a36 0%, #000000 70%);
            background-attachment: fixed;
            margin: 0;
        }

        .card {
            background: var(--bg-panel);
            backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px);
            border: 1px solid var(--border);
            border-radius: 24px;
            padding: 50px 40px;
            text-align: center;
            max-width: 450px;
            width: 90%;
            box-shadow: 0 30px 60px rgba(0,0,0,0.5);
            animation: popIn 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        .icon { 
            font-size: 4rem; 
            margin-bottom: 20px; 
            display: block; 
            text-shadow: 0 0 30px rgba(191, 90, 242, 0.3);
        }

        h1 { 
            font-size: 1.8rem; 
            margin-bottom: 10px; 
            font-weight: 700;
            background: linear-gradient(180deg, #fff, #ccc);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        p {
            color: var(--text-secondary);
            margin-bottom: 30px;
            font-size: 1rem;
            line-height: 1.5;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background: var(--accent);
            color: white;
            padding: 14px 35px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s;
            box-shadow: 0 0 20px rgba(191, 90, 242, 0.4);
        }
        .btn:hover { 
            transform: translateY(-3px); 
            box-shadow: 0 10px 30px rgba(191, 90, 242, 0.6);
            filter: brightness(1.1);
        }

        @keyframes popIn { from { opacity: 0; transform: scale(0.9); } to { opacity: 1; transform: scale(1); } }
    </style>
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>

    <div class="card">
        <% 
            jb.connect(); 
            
            // 1. Preluam datele trimise de m1_Categorii.jsp
            int aux = java.lang.Integer.parseInt(request.getParameter("id_categorie")); 
            String nume_categorie = request.getParameter("nume_categorie"); 
 
            // 2. Pregatim datele pentru update
            String[] valori = {nume_categorie}; 
            String[] campuri = {"nume_categorie"}; 
            
            // 3. Executam modificarea in baza de date
            jb.modificaTabela("categorii", "id_categorie", aux, campuri, valori); 
            
            jb.disconnect(); 
        %>

        <div class="icon">✅</div>
        <h1>Modificare Reușită!</h1>
        <p>Categoria a fost redenumită în <b>"<%= nume_categorie %>"</b> cu succes.</p>
        
        <a href="tabela_Categorii.jsp" class="btn">Înapoi la Tabel</a>
    </div>

</body>
</html>