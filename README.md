# Interfață Web pentru Gestiunea unei Baze de Date (JSP & MySQL)

Acest proiect a fost realizat de către **Vincene Eduard** din grupa **433A** pentru materia **Programarea Interfețelor pentru Baze de Date**.

##  Descriere Generală
Proiectul reprezintă o aplicație web dinamică destinată gestionării unei baze de date relaționale (MySQL) ce conține informații despre filme și categorii (asociere de tip M:N). 

Aplicația este construită pe platforma Java, utilizând tehnologia **JSP (Java Server Pages)** pentru interfața cu utilizatorul și un server **Apache Tomcat** pentru găzduire și procesarea cererilor HTTP. Logica de comunicare cu baza de date este decuplată și gestionată printr-o clasă dedicată de tip **JavaBean**.

##  Funcționalități Principale (CRUD)
* **Vizualizare (Read):** Datele sunt extrase din baza de date și afișate în tabele dinamice (ex: `tabela_Filme.jsp`). Pentru asocierile complexe (încadrări), se folosesc interogări de tip `INNER JOIN` pentru a afișa informații lizibile (numele filmului/categoriei în loc de ID).
* **Adăugare (Create):** Utilizatorul poate introduce date noi prin intermediul formularelor web. Cererile sunt preluate de fișiere de procesare (ex: `nou_Filme.jsp`) și inserate în baza de date.
* **Modificare (Update):** Permite selectarea unei singure înregistrări pentru editare. Formularul (ex: `modifica_Filme.jsp`) este pre-completat cu datele existente, iar la salvare se execută o comandă de tip `UPDATE`.
* **Ștergere (Delete):** Oferă posibilitatea de a șterge una sau mai multe înregistrări simultan prin bifarea unor checkbox-uri din interfață, acțiune procesată ulterior de fișiere precum `sterge_Filme.jsp`.

##  Structura Codului

### 1. Logica de Backend (Clasa `JavaBean`)
Această clasă servește ca un strat de intermediere (middleware) între paginile JSP și baza de date MySQL. Include:
* Metode de **conectare/deconectare** la server folosind driver-ul JDBC (`com.mysql.cj.jdbc.Driver`).
* Metode generice și specifice pentru interogări: `vedeTabela()`, `vedeIncadrari()` (returnează obiecte de tip `ResultSet`).
* Metode de manipulare a datelor: `adaugaFilm()`, `stergeDateTabela()`, `modificaTabela()`.

### 2. Interfața Frontend (Paginile JSP/HTML)
* **`index.html`**: Panoul principal de administrare.
* **Pagini de Vizualizare**: Instanțiază clasa JavaBean, apelează metodele de citire și folosesc bucle `while(rs.next())` pentru a genera cod HTML (rândurile tabelelor).
* **Pagini de Procesare**: Preiau datele din metodele POST/GET (`request.getParameter`), le validează și apelează funcțiile corespunzătoare din JavaBean pentru a modifica starea bazei de date.

##  Structura Bazei de Date
Baza de date cuprinde trei tabele interconectate:
* **`filme`**: id_film (PK), titlu, an_aparitie, durata, regizor.
* **`categorii`**: id_categorie (PK), nume_categorie.
* **`incadrare_filme`**: Tabela de joncțiune ce rezolvă relația M:N. Conține id_incadrare (PK), id_film (FK), id_categorie (FK) și tip (ENUM: Principală/Secundară).

---
**Tehnologii utilizate:** Java Server Pages (JSP), JavaBean, Apache Tomcat (Server), MySQL (JDBC), HTML, CSS.
