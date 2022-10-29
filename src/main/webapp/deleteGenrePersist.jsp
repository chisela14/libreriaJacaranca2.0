<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.jacaranda.dao.DaoGenre"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LJ - Género borrado</title>
</head>
<body>
	<%
	HttpSession se = request.getSession();
	String isSession = (String) session.getAttribute("login");
	String userSession = (String) session.getAttribute("user");
	if(isSession != null && userSession!=null && isSession.equals("True")){
		DaoGenre daog = new DaoGenre();
		String name = request.getParameter("name");
		System.out.println(name);
		try {
			daog.deleteGenre(name);
			%>
			<jsp:forward page="genreList.jsp"></jsp:forward>
		<%
		}catch (Exception e) {
			String message = e.getMessage();
			%>
			<jsp:forward page="errorBackToGenreTable.jsp"><jsp:param name="error" value="<%= message %>"/></jsp:forward>
			<%
		}
	} else {
		%><jsp:forward page="error.jsp?msg='No te has autenticado.'"></jsp:forward><%
	}%>
	
</body>
</html>