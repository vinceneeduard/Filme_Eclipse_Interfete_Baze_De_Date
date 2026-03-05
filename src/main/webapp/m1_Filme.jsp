<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editează Film - Studio</title>
    
    <style>
        :root {
            --bg-dark: #000000;
            --bg-panel: rgba(28, 28, 30, 0.75);
            --text-primary: #f5f5f7;
            --text-secondary: #86868b;
            --accent: #2997ff; /* ALBASTRU */
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
            /* Gradient Albastru Jos */
            background-image: radial-gradient(circle at 50% 100%, #0f1b2b 0%, #000000 70%);
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
        
        input[type="text"], input[type="number"] {
            width: 100%; padding: 14px;
            background: var(--input-bg);
            border: 1px solid var(--border);
            border-radius: 12px;
            color: white; font-size: 1rem;
            transition: all 0.3s;
            outline: none;
        }
        
        input:focus { border-color: var(--accent); background: black; box-shadow: 0 0 0 2px rgba(41, 151, 255, 0.3); }

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
            box-shadow: 0 0 20px rgba(41, 151, 255, 0.4); 
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
            <h1>Editează Film</h1>
            <div class="subtitle">Modifică detaliile din baza de date</div>
        </div>

        <% 
            jb.connect(); 
            
            // Preluam ID-ul filmului (PrimaryKey)
            String pk = request.getParameter("primarykey");
            int aux = 0;
            
            String titlu = "";
            int an_aparitie = 0;
            int durata = 0;
            String regizor = "";

            if (pk != null) {
                aux = java.lang.Integer.parseInt(pk);
                
                // Folosim intoarceLinieDupaId
                ResultSet rs = jb.intoarceLinieDupaId("filme", "id_film", aux); 
                
                if (rs.next()) { // Verificam daca exista rezultatul
                    
                    titlu = rs.getString("titlu"); 
                    an_aparitie = rs.getInt("an_aparitie"); 
                    durata = rs.getInt("durata"); 
                    regizor = rs.getString("regizor"); 
                }
                rs.close(); 
            }
            jb.disconnect(); 
        %>

        <form action="m2_Filme.jsp" method="post">
            
            <label>ID Film (Nu se poate modifica)</label>
            <input type="text" name="id_film" value="<%= aux %>" readonly />

            <label>Titlu Film</label>
            <input type="text" name="titlu" value="<%= titlu %>" required />

            <label>An Apariție</label>
            <input type="number" name="an_aparitie" value="<%= an_aparitie %>" required />

            <label>Durata (minute)</label>
            <input type="number" name="durata" value="<%= durata %>" required />

            <label>Regizor</label>
            <input type="text" name="regizor" value="<%= regizor %>" />

            <input type="submit" value="Salvează Modificările" />
            
        </form>

        <a href="modifica_Filme.jsp" class="cancel-link">Anulează și Întoarce-te</a>

    </div>

</body>
</html>