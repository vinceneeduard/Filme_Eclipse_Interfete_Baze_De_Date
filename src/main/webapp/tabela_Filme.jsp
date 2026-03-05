<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tabela Filme - Studio</title>

    <style>
        :root {
            --bg-dark: #000000;
            --bg-panel: rgba(28, 28, 30, 0.75);
            --text-primary: #f5f5f7;
            --text-secondary: #86868b;
            --accent: #2997ff; /* ALBASTRU - Filme */
            --danger: #ff453a;
            --border: rgba(255, 255, 255, 0.1);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; }

        body {
            background-color: var(--bg-dark);
            color: var(--text-primary);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start; /* Aliniere sus pentru tabele lungi */
            padding-top: 50px;
            padding-bottom: 50px;
            
            /* FUNDAL ALBASTRU JOS */
            background-image: radial-gradient(circle at 50% 100%, #0f1b2b 0%, #000000 70%);
            background-attachment: fixed;
        }

        .dashboard-container {
            width: 95%; max-width: 1100px;
            background: var(--bg-panel);
            backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px);
            border: 1px solid var(--border); border-radius: 24px; padding: 40px;
            box-shadow: 0 30px 60px rgba(0,0,0,0.5);
            animation: fadeIn 0.6s ease-out;
            height: auto;
        }

        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; border-bottom: 1px solid var(--border); padding-bottom: 20px; }
        h1 { font-size: 2.2rem; font-weight: 700; color: white; }

        /* Butoane */
        .btn { text-decoration: none; padding: 10px 20px; border-radius: 12px; font-weight: 500; font-size: 0.9rem; transition: all 0.3s ease; display: inline-flex; align-items: center; gap: 8px; }
        .btn-add { background: rgba(41, 151, 255, 0.15); color: var(--accent); border: 1px solid rgba(41, 151, 255, 0.3); }
        .btn-add:hover { background: var(--accent); color: white; box-shadow: 0 0 15px rgba(41, 151, 255, 0.4); }
        .btn-home { background: rgba(255, 255, 255, 0.1); color: var(--text-primary); border: 1px solid var(--border); }
        .btn-home:hover { background: rgba(255, 255, 255, 0.2); }

        /* Tabel */
        .table-wrapper { overflow-x: auto; border-radius: 16px; background: rgba(0, 0, 0, 0.2); border: 1px solid var(--border); }
        table { width: 100%; border-collapse: collapse; text-align: left; }
        th { background: rgba(255, 255, 255, 0.05); color: var(--text-secondary); font-size: 0.8rem; text-transform: uppercase; letter-spacing: 1.2px; padding: 18px 24px; border-bottom: 1px solid var(--border); }
        td { padding: 20px 24px; border-bottom: 1px solid rgba(255, 255, 255, 0.05); color: var(--text-primary); font-size: 0.95rem; }
        tr:hover td { background: rgba(255, 255, 255, 0.03); }

        /* Checkbox */
        input[type="checkbox"] { accent-color: var(--accent); width: 18px; border-radius: 50%;;height: 18px; cursor: pointer; }
        
        

        /* Footer */
        .table-footer { margin-top: 25px; display: flex; justify-content: flex-end; }
        .btn-delete { background: rgba(255, 69, 58, 0.15); color: var(--danger); border: 1px solid rgba(255, 69, 58, 0.3); padding: 12px 30px; border-radius: 50px; cursor: pointer; font-size: 1rem; font-weight: 600; transition: all 0.3s; }
        .btn-delete:hover { background: var(--danger); color: white; box-shadow: 0 0 20px rgba(255, 69, 58, 0.4); transform: scale(1.02); }

        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>

    <div class="dashboard-container">
        
        <div class="page-header">
            <h1>Catalog Filme</h1>
            <div class="controls">
                <a href="index.html" class="btn btn-home">🏠 Home</a>
                <a href="nou_Filme.jsp" class="btn btn-add">+ Adaugă Film</a>
            </div>
        </div>

        <form action="sterge_Filme.jsp" method="post">
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th style="width: 50px; text-align: center;">Mark</th>
                            <th style="width: 80px;">ID</th>
                            <th>Titlu Film</th>
                            <th>An Aparitie</th>
                            <th>Durata</th>
                            <th>Regizor</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        jb.connect();
                        ResultSet rs = jb.vedeTabela("filme");
                        long x;
                        while (rs.next()) {
                            x = rs.getInt("id_film");
                        %>
                        <tr>
                            <td style="text-align: center;">
                                <input type="checkbox" name="primarykey" value="<%=x%>" />
                            </td>
                            <td style="color: var(--text-secondary); font-family: monospace;">#<%=x%></td>
                            <td style="font-weight: 600; color: white;"><%=rs.getString("titlu")%></td>
                            <td>
                                <span style="background: rgba(255,255,255,0.1); padding: 4px 8px; border-radius: 6px; font-size: 0.85rem;">
                                    <%=rs.getInt("an_aparitie")%>
                                </span>
                            </td>
                            <td style="color: var(--text-secondary);"><%=rs.getInt("durata")%> min</td>
                            <td><%=rs.getString("regizor")%></td>
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
                <input type="submit" value="Șterge Selecția" class="btn-delete">
            </div>
        </form>

    </div>

</body>
</html>