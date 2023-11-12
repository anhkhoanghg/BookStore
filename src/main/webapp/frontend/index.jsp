<html lang="en">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>

    <title>Maple BookStore</title>


    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="shortcut icon" href="/assets/img/icons/books.ico">
    <jsp:include page="/importCss.jsp" />
    <link rel="stylesheet" href="/css/owl-carousel.css"/>
</head>
<body>
<%@include file="/components/Header.jsp"%>
<section class="banner">
    <div class="container-fluid">
        <div class="owl-carousel owl-1">
            <div><img src="/assets/img/image1.png" alt="Image" class="img-fluid"></div>
            <div><img src="/assets/img/image2.jpeg" alt="Image" class="img-fluid"></div>
            <div><img src="/assets/img/image3.png" alt="Image" class="img-fluid"></div>
        </div>
    </div>
</section>

<%@include file="/frontend/SectionHomePage/MostRecent.jsp"%>
<%@include file="/frontend/SectionHomePage/BestSelling.jsp"%>
<%@include file="/frontend/SectionHomePage/MostFavored.jsp"%>

<%@include file="/components/Footer.jsp"%>


</body>
    <jsp:include page="/importLib.jsp"/>
</html>