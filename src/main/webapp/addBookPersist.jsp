<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.SQLException"%>
<%@ page import="com.jacaranda.dao.DaoBook"%>
<%@ page import="com.jacaranda.model.Book"%>
<%@page import="java.time.LocalDate"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LJ - Añadir libro</title>
</head>
<body>

<% 
	HttpSession se = request.getSession();
	String isSession = (String) session.getAttribute("login");
	String userSession = (String) session.getAttribute("user");
	if(isSession != null && userSession !=null && isSession.equals("True")){
	
		String empty = "";
									
		String newIsbn = request.getParameter("isbn");
		String newTitle = request.getParameter("title");
		String newAuthor = request.getParameter("author");
		String newPublished_date = request.getParameter("published_date");
		int newQuantity = Integer.parseInt(request.getParameter("quantity"));
		double newPrice = Double.parseDouble(request.getParameter("price"));
		
		
		if(newIsbn == null || empty.equals(newIsbn.trim()) || newTitle == null || empty.equals(newTitle.trim()) || newAuthor == null || empty.equals(newAuthor.trim()) ||
		newPublished_date == null || empty.equals(newPublished_date) || newQuantity < 0 || newPrice < 0){%>
			<jsp:forward
				page="errorAddBook.jsp?msg='Los campos no son correctos'"></jsp:forward>
		<% } else {
			LocalDate date = LocalDate.parse(newPublished_date);
			
			DaoBook newDaoBook = new DaoBook();
			
			try {
				newDaoBook.addBook(newIsbn, newTitle, newAuthor, date, newQuantity, newPrice);%>
				<jsp:forward
				page="bookPage.jsp"></jsp:forward>
				
			<%} catch (Exception e){
					String message = e.getMessage();%>
				<jsp:forward page="errorBackToTable.jsp"><jsp:param name="error" value="<%= message %>"/></jsp:forward>
			<%}
			
		}

	} else {%>
	<jsp:forward
		page="error.jsp?msg='No te has autenticado'"></jsp:forward>
	<%}%>


</body>
</html>