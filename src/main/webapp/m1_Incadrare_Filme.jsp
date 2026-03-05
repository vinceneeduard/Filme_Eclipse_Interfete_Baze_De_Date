<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifică Încadrare - Studio</title>
    
    <style>
        :root {
            --bg-dark: #000000;
            --bg-panel: rgba(28, 28, 30, 0.75);
            --text-primary: #f5f5f7;
            --text-secondary: #86868b;
            --accent: #30d158; /* VERDE */
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
            /* Gradient Verde Jos */
            background-image: radial-gradient(circle at 50% 100%, #0d2b14 0%, #000000 70%);
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
        .btn-home-abs:hover { background: var(--accent); border-color: var(--accent); color: black; }

        /* --- INPUTURI & LABEL --- */
        label { display: block; margin-bottom: 8px; color: var(--text-secondary); font-size: 0.85rem; margin-top: 20px; font-weight: 500; text-transform: uppercase; letter-spacing: 0.5px; }
        
        input[type="text"] {
            width: 100%; padding: 14px;
            background: var(--input-bg); border: 1px solid var(--border); border-radius: 12px;
            color: white; font-size: 1rem; transition: all 0.3s; outline: none;
        }
        
        /* Stil special pentru SELECT (Dropdown) */
        select {
            width: 100%; padding: 14px;
            background: var(--input-bg); border: 1px solid var(--border); border-radius: 12px;
            color: white; font-size: 1rem; cursor: pointer; appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='white'%3e%3cpath d='M7 10l5 5 5-5z'/%3e%3c/svg%3e");
            background-repeat: no-repeat; background-position: right 15px center; background-size: 20px;
        }
        
        select:focus, input:focus { border-color: var(--accent); background: black; box-shadow: 0 0 0 2px rgba(48, 209, 88, 0.3); }
        option { background-color: #1c1c1e; color: white; padding: 10px; }

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
            box-shadow: 0 0 20px rgba(48, 209, 88, 0.4); 
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
            <h1>Editează Legătură</h1>
            <div class="subtitle">Asociere Film - Categorie</div>
        </div>

        <% 
            jb.connect(); 
            
            // 1. Preluam ID-ul incadrarii
            int aux = java.lang.Integer.parseInt(request.getParameter("primarykey")); 
            
            // 2. Aducem datele actuale
            ResultSet rs = jb.intoarceIncadrareId(aux); 
            rs.first(); 
            
            int currentIdFilm = rs.getInt("id_film"); 
            int currentIdCategorie = rs.getInt("id_categorie"); 
            String currentTip = rs.getString("tip");

            // 3. Aducem listele complete pentru Dropdown-uri
            ResultSet rsFilme = jb.vedeTabela("filme"); 
            ResultSet rsCategorii = jb.vedeTabela("categorii"); 
            
            int id_f, id_c;
            String titlu, an, nume_cat;
        %>

        <form action="m2_Incadrare_Filme.jsp" method="post">
            
            <label>ID Încadrare</label>
            <input type="text" name="id_incadrare" value="<%= aux %>" readonly />

            <label>Film</label>
            <select name="id_film">
                <% 
                    while (rsFilme.next()) { 
                        id_f = rsFilme.getInt("id_film"); 
                        titlu = rsFilme.getString("titlu"); 
                        an = rsFilme.getString("an_aparitie"); 
                        
                        // Verificam pre-selectia
                        if (id_f == currentIdFilm) { 
                %>
                    <option selected="selected" value="<%= id_f%>">
                        <%= titlu%> (<%= an%>)
                    </option>
                <% 
                        } else { 
                %>
                    <option value="<%= id_f%>">
                        <%= titlu%> (<%= an%>)
                    </option>
                <% 
                        } 
                    } 
                %>
            </select>

            <label>Categorie</label>
            <select name="id_categorie">
                <% 
                    while (rsCategorii.next()) { 
                        id_c = rsCategorii.getInt("id_categorie"); 
                        nume_cat = rsCategorii.getString("nume_categorie"); 
                        
                        if (id_c == currentIdCategorie) { 
                %>
                    <option selected="selected" value="<%= id_c%>">
                        <%= nume_cat%>
                    </option>
                <% 
                        } else { 
                %>
                    <option value="<%= id_c%>">
                        <%= nume_cat%>
                    </option>
                <% 
                        } 
                    } 
                %>
            </select>

            <label>Tip Rol</label>
            <select name="tip">
                <% if ("Principala".equals(currentTip)) { %>
                    <option selected="selected" value="Principala">Principala</option>
                    <option value="Secundara">Secundara</option>
                <% } else { %>
                    <option value="Principala">Principala</option>
                    <option selected="selected" value="Secundara">Secundara</option>
                <% } %>
            </select>

            <input type="submit" value="Salvează Modificările" />
            
        </form>

        <a href="modifica_Incadrare_Filme.jsp" class="cancel-link">Anulează</a>

        <% 
            // Inchidem resursele
            rs.close(); 
            rsFilme.close(); 
            rsCategorii.close(); 
            jb.disconnect(); 
        %>
    </div>

</body>
</html>