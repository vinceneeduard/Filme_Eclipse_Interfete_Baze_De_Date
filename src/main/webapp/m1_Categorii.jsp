<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifică Categorie - Studio</title>
    
    <style>
        :root {
            --bg-dark: #000000;
            --bg-panel: rgba(28, 28, 30, 0.75);
            --text-primary: #f5f5f7;
            --text-secondary: #86868b;
            --accent: #bf5af2; /* MOV - Specific Categorii */
            --input-bg: rgba(255, 255, 255, 0.05);
            --input-bg-readonly: rgba(255, 255, 255, 0.02);
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
        }

        /* --- CONTAINER FORMULAR --- */
        .form-container {
            width: 100%;
            max-width: 500px;
            background: var(--bg-panel);
            backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px);
            border: 1px solid var(--border);
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 30px 60px rgba(0,0,0,0.5);
            animation: fadeIn 0.5s ease-out;
            position: relative;
        }

        /* Header si Buton Home */
        .form-header { text-align: center; margin-bottom: 30px; position: relative; }
        h1 { font-size: 1.8rem; font-weight: 700; color: white; margin-bottom: 5px; }
        .subtitle { font-size: 0.9rem; color: var(--text-secondary); }

        .btn-home-abs {
            position: absolute; top: -20px; right: -20px;
            text-decoration: none; font-size: 1.2rem; background: rgba(255,255,255,0.1);
            width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center;
            transition: all 0.2s; border: 1px solid var(--border);
        }
        .btn-home-abs:hover { background: var(--accent); border-color: var(--accent); }

        /* --- INPUTURI --- */
        label { display: block; margin-bottom: 8px; color: var(--text-secondary); font-size: 0.85rem; margin-top: 20px; font-weight: 500; text-transform: uppercase; letter-spacing: 0.5px; }
        
        input[type="text"] {
            width: 100%; padding: 14px;
            background: var(--input-bg);
            border: 1px solid var(--border);
            border-radius: 12px;
            color: white; font-size: 1rem;
            transition: all 0.3s;
            outline: none;
        }
        
        input:focus { border-color: var(--accent); background: black; box-shadow: 0 0 0 2px rgba(191, 90, 242, 0.3); }

        /* Stil pentru ID (Readonly) */
        input[readonly] {
            background: var(--input-bg-readonly);
            color: var(--text-secondary);
            border-style: dashed;
            cursor: not-allowed;
        }

        /* --- BUTON SUBMIT --- */
        input[type="submit"] {
            width: 100%; padding: 16px;
            background: var(--accent);
            color: white; border: none;
            border-radius: 50px; /* Pill Shape */
            font-weight: 600; font-size: 1rem;
            cursor: pointer; margin-top: 35px;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        input[type="submit"]:hover { 
            transform: scale(1.02); 
            box-shadow: 0 0 20px rgba(191, 90, 242, 0.4); 
            filter: brightness(1.1);
        }
        
        .cancel-link {
            display: block; text-align: center; margin-top: 20px;
            color: var(--text-secondary); text-decoration: none; font-size: 0.9rem; transition: color 0.2s;
        }
        .cancel-link:hover { color: white; }

        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>

    <div class="form-container">
        <div class="form-header">
            <a href="index.html" class="btn-home-abs" title="Home">🏠</a>
            <h1>Modifică Categorie</h1>
            <div class="subtitle">Actualizează denumirea categoriei</div>
        </div>

        <% 
            jb.connect(); 
            
            String pk = request.getParameter("primarykey");
            int aux = 0;
            String nume_categorie = "";

            if (pk != null) {
                aux = java.lang.Integer.parseInt(pk);
                
                // Folosim logica ta specifica: intoarceLinieDupaId
                ResultSet rs = jb.intoarceLinieDupaId("categorii", "id_categorie", aux); 
                
                if (rs.next()) { // Verificam daca exista rezultatul
                    nume_categorie = rs.getString("nume_categorie");
                }
                rs.close(); 
            }
            jb.disconnect(); 
        %>

        <form action="m2_Categorii.jsp" method="post">
            
            <label>ID Categorie</label>
            <input type="text" name="id_categorie" value="<%= aux %>" readonly />

            <label>Nume Categorie</label>
            <input type="text" name="nume_categorie" value="<%= nume_categorie %>" required autocomplete="off"/>

            <input type="submit" value="Salvează Modificarea" />
            
        </form>

        <a href="modifica_Categorii.jsp" class="cancel-link">Anulează și Întoarce-te</a>

    </div>

</body>
</html>