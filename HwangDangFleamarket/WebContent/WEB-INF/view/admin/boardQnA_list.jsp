<%@ page contentType="text/html;charset=utf-8"%>
<%@taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>황당 플리마켓 QnA</title>
</head>
<body>
<h1>황당 플리마켓 QnA</h1>

<c:forEach var="qna"   items="${requestScope.list }" >
	${qna } <br/>
</c:forEach>
</body>
</html>
