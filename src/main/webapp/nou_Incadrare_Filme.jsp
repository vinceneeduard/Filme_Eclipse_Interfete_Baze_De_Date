<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <title>Incadrare Noua - Studio</title>
    
    <style>
        :root {
            --bg-dark: #000000;
            --bg-panel: rgba(28, 28, 30, 0.75);
            --text-primary: #f5f5f7;
            --text-secondary: #86868b;
            --accent: #30d158; /* VERDE - Incadrari */
            --input-bg: rgba(255, 255, 255, 0.05);
            --border: rgba(255, 255, 255, 0.1);
        }
        * { box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; margin: 0; padding: 0; }
        
        body {
            background-color: var(--bg-dark); color: var(--text-primary);
            min-height: 100vh; display: flex; justify-content: center; align-items: center;
            
            /* LUMINĂ VERDE JOS */
            background-image: radial-gradient(circle at 50% 100%, #0d2b14 0%, #000000 70%);
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
        
        label { display: block; margin-bottom: 8px; color: var(--text-secondary); font-size: 0.9rem; margin-top: 20px; }
        
        /* Dropdowns */
        select {
            width: 100%; padding: 14px;
            background: var(--input-bg); border: 1px solid var(--border); border-radius: 12px;
            color: white; font-size: 1rem; cursor: pointer; appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='white'%3e%3cpath d='M7 10l5 5 5-5z'/%3e%3c/svg%3e");
            background-repeat: no-repeat; background-position: right 15px center; background-size: 20px;
        }
        select:focus { border-color: var(--accent); background-color: black; outline: none; box-shadow: 0 0 0 2px rgba(48, 209, 88, 0.3); }
        option { background-color: #000; color: white; padding: 10px; }

        input[type="submit"] {
            width: 100%; padding: 16px; background: var(--accent); color: white;
            border: none; border-radius: 12px; font-weight: 600; font-size: 1rem; cursor: pointer;
            transition: transform 0.2s; margin-top: 35px;
        }
        input[type="submit"]:hover { filter: brightness(1.1); transform: scale(1.02); }
        
        .back-link { display: block; text-align: center; margin-top: 20px; color: var(--text-secondary); text-decoration: none; font-size: 0.9rem; transition: color 0.3s; }
        .back-link:hover { color: white; }

        .msg-box { padding: 15px; border-radius: 12px; text-align: center; margin-bottom: 20px; font-weight: 500; }
        .success { background: rgba(48, 209, 88, 0.2); color: #30d158; border: 1px solid rgba(48, 209, 88, 0.3); }

        @keyframes popIn { from { opacity: 0; transform: scale(0.9); } to { opacity: 1; transform: scale(1); } }
    </style>
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>

    <div class="form-container">
        <% 
            jb.connect();
        
            String id_film_str = request.getParameter("id_film");
            String id_categorie_str = request.getParameter("id_categorie");
            String tip = request.getParameter("tip");

            if (id_film_str != null && id_categorie_str != null) {
                int id_f = Integer.parseInt(id_film_str);
                int id_c = Integer.parseInt(id_categorie_str);
                
                jb.adaugaIncadrare(id_f, id_c, tip); 
        %>
            <div class="msg-box success">🔗 Legătură creată cu succes!</div>
            <a href="tabela_Incadrare_Filme.jsp" class="back-link">← Înapoi la Tabel</a>
            <a href="nou_Incadrare_Filme.jsp" class="back-link" style="margin-top: 10px;">+ Adaugă alta</a>
        <% 
            } else { 
                ResultSet rsFilme = jb.vedeTabela("filme");
                ResultSet rsCategorii = jb.vedeTabela("categorii");
        %>
            <h1>Încadrare Nouă</h1>
            
            <form action="nou_Incadrare_Filme.jsp" method="post">
                
                <label>Alege Filmul</label>
                <select name="id_film">
                    <% while(rsFilme.next()){ %>
                        <option value="<%= rsFilme.getInt("id_film") %>">
                            <%= rsFilme.getString("titlu") %> (<%= rsFilme.getInt("an_aparitie") %>)
                        </option>
                    <% } %>
                </select>

                <label>Alege Categoria</label>
                <select name="id_categorie">
                    <% while(rsCategorii.next()){ %>
                        <option value="<%= rsCategorii.getInt("id_categorie") %>">
                            <%= rsCategorii.getString("nume_categorie") %>
                        </option>
                    <% } %>
                </select>

                <label>Tipul Rolului</label>
                <select name="tip">
                    <option value="Principala">Principala (Gen de baza)</option>
                    <option value="Secundara">Secundara (Sub-gen)</option>
                </select>

                <input type="submit" value="Creează Legătura" />
            </form>
            
            <a href="tabela_Incadrare_Filme.jsp" class="back-link">Anulează</a>
        <% 
            } 
            jb.disconnect();
        %>
    </div>

</body>
</html>