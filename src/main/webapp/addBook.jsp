<%@page import="java.sql.SQLException"%>
<%@page import="com.jacaranda.model.BookException"%>
<%@page import="com.jacaranda.dao.DaoBook"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LJ - Añadir libro</title>
<link href="css/forms.css" rel="stylesheet" id="bootstrap-css">
<script>
	function TDate() {
		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth() + 1; //January is 0!
		var yyyy = today.getFullYear();
		if (dd < 10) {
			dd = '0' + dd;
		}
		if (mm < 10) {
			mm = '0' + mm;
		}

		today = yyyy + '-' + mm + '-' + dd;
		document.getElementById("published_date").setAttribute("max", today);
	}


</script>
</head>

<body>

	<% 
	HttpSession se = request.getSession();
	String isSession = (String) session.getAttribute("login");
	String userSession = (String) session.getAttribute("user");
	if(isSession != null && userSession !=null && isSession.equals("True")){
		String genre = request.getParameter("genre");
	%>

	<section class="get-in-touch">
		<h1 class="title">Añadir libro</h1>
		<form class="contact-form row" id="addBookForm" action="addBookPersist.jsp" method="post">
			<div class="form-field col-lg-6">
				<input id="isbn" class="input-text js-input" type="text" name="isbn" maxlength="10" minlength="10" pattern="[0-9]{10}" placeholder="XXXXXXXXXX - Ejemplo: 0123456789" required>
				<label class="label" for="isbn">ISBN</label>
			</div>
			<div class="form-field col-lg-6 ">
				<input id="title" class="input-text js-input" type="text" name="title" maxlength="50" minlength="1" placeholder="Nombre del libro" required>
				<label class="label" for="title">Título</label>
			</div>
			<div class="form-field col-lg-6 ">
				<input id="author" class="input-text js-input" type="text" name="author"  maxlength="50" minlength="1" placeholder="Nombre del autor" required>
				<label class="label" for="author">Autor</label>
			</div>
			<div class="form-field col-lg-6 ">
				<input  id="published_date" class="input-text js-input" name="published_date" type='date' min='1899-01-01' max='2000-13-13' onclick="TDate()" required></input>
				<label class="label" for="published_date">Fecha de publicación</label>
			</div>
			<div class="form-field col-lg-6">
				<input id="quantity" class="input-text js-input" type="number" name="quantity" step="1" min="0" placeholder="Ejemplo: 5" required> 
				<label class="label" for="quantity">Cantidad</label>
			</div>
			<div class="form-field col-lg-6 ">
				<input id="price" class="input-text js-input" name="price" type="number" min="0" step="0.01" placeholder="Ejemplo: 1.99" required>
				<label class="label" for="price">Precio</label>
			</div>
			<div class="form-field col-lg-12">
				<button class="submit-btn" type="submit"  name="addBook">Añadir</button>
				<a href="bookList.jsp?genre=<%= genre %>" class="back-btn">Cancelar</a>
			</div>
			<input type="hidden" value ="<%=genre%>" name="genre">
		
		</form>
	</section>

	<%}else {%>
	<jsp:forward
		page="error.jsp?msg='No te has autenticado'"></jsp:forward>
<%}%>
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

</body>
</html>