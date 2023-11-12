<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Login</title>
    <jsp:include page="/import.jsp"/>
    <link rel="shortcut icon" href="/assets/img/icons/books.ico">
    <link href="/css/verify.css" rel="stylesheet" type="text/css">
</head>
<body>

    <div class="row">
        <div class="col-md-12">
            <div class="main-verification-input-wrap">
                <form action="/resend_code" method="post">
                    <ul>
                        <li>You will recieve a verification code on your mail after you registered. Enter that code below.</li>
                        <li>If somehow, you did not recieve the verification email then <br>
                             <button class="btn-primary btn-sm" type="submit">Resend</button>
                        </li>
                    </ul>
                </form>
                <div class="main-verification-input fl-wrap">
                    <form method="post" action="/verify">
                        <div class="main-verification-input-item">
                            <input type="text" name="code" value="" placeholder="Enter the verification code">
                        </div>
                        <button type="submit" class="main-verification-button">Verify Now</button>
                    </form>
                </div>
            </div>
        </div>
    </div>


<script src="/js/register.js"></script>
</body>
</html>
