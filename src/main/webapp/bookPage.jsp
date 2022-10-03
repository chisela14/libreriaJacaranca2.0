<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import="com.jacaranda.articles.DaoBook"%>
<%@ page import="com.jacaranda.articles.Book"%>
<%@ page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book database</title>
<link rel="stylesheet" type="text/css" href="bookPage.css">
</head>
<body>
	<% 
	/* HttpSession se = request.getSession();
	String isSession = (String) session.getAttribute("login");
	String userSession = (String) session.getAttribute("user");
	if(isSession != null && userSession !=null && isSession.equals("True")){ */
		DaoBook daob = new DaoBook();
		ArrayList<Book> bookList = null;
		try {
			bookList = daob.getBooks();
		} catch (Exception e) {
			
		}
		
		%>
		<a href="login.jsp">Cerrar sesión</a>
		<h1>Listado de libros de la Librería JACARANDÁ</h1>
		
		<a href="addBook.jsp"><img src="images/add.png" width="30px"></a>
		
		<table cellspacing="2" cellpadding="2">

		<tr>
			<th>ISBN</th>
			<th>Título</th>
			<th>Autor</th>
			<th>Fecha de publicación</th>
			<th>Cantidad</th>
			<th>Precio</th>
			<th>Stock</th>
			<th></th>
			<th></th>
		</tr>
		
		<%
		// Iterating through subjectList

		Iterator<Book> iterator = bookList.iterator();  // Iterator interface
			
		while(iterator.hasNext()) { // iterate through all the data until the last record
			
			Book bookDetails = iterator.next(); 
			char stock = 'N';
			if(bookDetails.getStock()==1) {
				stock = 'S';
			}
			%>
			<tr>
				<td><%=bookDetails.getIsbn()%></td>
				<td><%=bookDetails.getTitle()%></td>
				<td><%=bookDetails.getAuthor()%></td>
				<td><%=bookDetails.getPublishedDate()%></td>
				<td><%=bookDetails.getQuantity()%></td>
				<td><%=bookDetails.getPrice()%></td>
				<td><%=stock%></td>
				<td><a href="deleteBook.jsp"><img src="images/delete.png" id="<%=bookDetails.getIsbn()%>" width="30px"></a></td>
				<td><a href="updateBook.jsp"><img src="images/update.png" id="<%=bookDetails.getIsbn()%>" width="30px"></a></td>
			</tr>
			<%
		}
		
		%>
		</table>
		<%-- %>
		
	<%}else{%>
		<jsp:forward page="error.jsp?msg='No has iniciado sesión'"></jsp:forward>
		<!-- Añadir botón para redireccionar a iniciar sesión -->
	<%}
	%> --%>

</body>
</html>