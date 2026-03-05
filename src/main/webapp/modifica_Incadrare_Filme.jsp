<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifica Incadrare - Studio</title>

    <style>
        :root {
            --bg-dark: #000000;
            --bg-panel: rgba(28, 28, 30, 0.75);
            --text-primary: #f5f5f7;
            --text-secondary: #86868b;
            --accent: #30d158; /* VERDE - Incadrari */
            --border: rgba(255, 255, 255, 0.1);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; }

        body {
            background-color: var(--bg-dark);
            color: var(--text-primary);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding-top: 50px;
            padding-bottom: 50px;
            /* LUMINĂ VERDE JOS */
            background-image: radial-gradient(circle at 50% 100%, #0d2b14 0%, #000000 70%);
            background-attachment: fixed;
        }

        .dashboard-container {
            width: 98%; max-width: 1300px;
            background: var(--bg-panel);
            backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px);
            border: 1px solid var(--border); border-radius: 24px; padding: 40px;
            box-shadow: 0 30px 60px rgba(0,0,0,0.5);
            animation: fadeIn 0.6s ease-out;
            height: auto;
        }

        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; border-bottom: 1px solid var(--border); padding-bottom: 20px; }
        h1 { font-size: 2.2rem; font-weight: 700; color: white; }

        .btn-home { 
            text-decoration: none; padding: 10px 20px; border-radius: 12px; font-weight: 500; font-size: 0.9rem; 
            background: rgba(255, 255, 255, 0.1); color: var(--text-primary); border: 1px solid var(--border); transition: all 0.3s;
        }
        .btn-home:hover { background: rgba(255, 255, 255, 0.2); }

        .table-wrapper { overflow-x: auto; border-radius: 16px; background: rgba(0, 0, 0, 0.2); border: 1px solid var(--border); }
        table { width: 100%; border-collapse: collapse; text-align: left; }
        th { background: rgba(255, 255, 255, 0.05); color: var(--text-secondary); font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1px; padding: 15px 20px; border-bottom: 1px solid var(--border); white-space: nowrap; }
        td { padding: 18px 20px; border-bottom: 1px solid rgba(255, 255, 255, 0.05); color: var(--text-primary); font-size: 0.9rem; }
        tr:hover td { background: rgba(255, 255, 255, 0.03); cursor: pointer; }

        /* Badge pentru tip rol */
        .badge { padding: 5px 10px; border-radius: 6px; font-size: 0.8rem; font-weight: 600; letter-spacing: 0.5px; }
        .badge-main { background: rgba(41, 151, 255, 0.2); color: #2997ff; border: 1px solid rgba(41, 151, 255, 0.3); }
        .badge-sec { background: rgba(255, 159, 10, 0.2); color: #ff9f0a; border: 1px solid rgba(255, 159, 10, 0.3); }

        input[type="radio"] { 
            appearance: none; -webkit-appearance: none; width: 20px; height: 20px;
            border: 2px solid var(--text-secondary); border-radius: 50%; background: transparent; cursor: pointer; transition: all 0.2s ease;
        }
        input[type="radio"]:checked {
            border-color: var(--accent); box-shadow: inset 0 0 0 4px var(--bg-dark); background-color: var(--accent);
        }

        .table-footer { margin-top: 30px; display: flex; justify-content: flex-end; }
        .btn-modify { 
            background: rgba(48, 209, 88, 0.15); 
            color: var(--accent); border: 1px solid var(--accent); 
            padding: 12px 36px; border-radius: 50px; cursor: pointer; font-size: 1rem; font-weight: 600; transition: all 0.3s; 
            letter-spacing: 0.5px;
        }
        .btn-modify:hover { 
            background: var(--accent); color: #000; 
            box-shadow: 0 0 20px rgba(48, 209, 88, 0.4); 
            transform: translateY(-2px); 
        }

        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
    </style>
    <script>
        function selectRow(id) {
            document.getElementById('radio_' + id).checked = true;
        }
    </script>
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>

    <div class="dashboard-container">
        
        <div class="page-header">
            <h1>Modifică Încadrări</h1>
            <a href="index.html" class="btn-home">🏠 Home</a>
        </div>

        <form action="m1_Incadrare_Filme.jsp" method="post">
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th style="width: 50px; text-align: center;">Select</th>
                            <th>ID Link</th>
                            <th>Film (Titlu)</th>
                            <th>An</th>
                            <th>Categorie</th>
                            <th>Tip Rol</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            jb.connect(); 
                            // Apelam metoda pentru a vedea si numele, nu doar ID-urile
                            ResultSet rs = jb.vedeIncadrari(); 
                            long x; 
                            while (rs.next()) { 
                                x = rs.getInt("id_incadrare"); 
                                String tip = rs.getString("tip");
                        %>
                        <tr onclick="selectRow(<%=x%>)">
                            <td style="text-align: center;">
                                <input type="radio" id="radio_<%=x%>" name="primarykey" value="<%=x%>" required onclick="event.stopPropagation()" />
                            </td>
                            <td style="color: var(--text-secondary); font-family: monospace;">#<%= x%></td>
                            
                            <td style="font-weight: 600;"><%= rs.getString("titlu")%></td>
                            <td><span style="opacity: 0.7;"><%= rs.getInt("an_aparitie")%></span></td>
                            
                            <td style="color: #bf5af2; font-weight: 500;"><%= rs.getString("nume_categorie")%></td>
                            
                            <td>
                                <% if(tip.equals("Principala")) { %>
                                    <span class="badge badge-main">PRINCIPALA</span>
                                <% } else { %>
                                    <span class="badge badge-sec">SECUNDARA</span>
                                <% } %>
                            </td>
                        </tr>
                        <% 
                            } 
                            rs.close(); 
                            jb.disconnect(); 
                        %>
                    </tbody>
                </table>
            </div>

            <div class="table-footer">
                <input type="submit" value="Modifică Legătura" class="btn-modify">
            </div>
        </form>

    </div>
</body>
</html>