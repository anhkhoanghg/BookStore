
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Manage Reviews</title>
    <jsp:include page="/import.jsp"/>
    <link href="/css/global.css" rel="stylesheet" type="text/css">
    <link href="/css/full_height_scroll.css" rel="stylesheet" type="text/css">
    <link href="/css/icon.css" rel="stylesheet" type="text/css">
</head>
<body>
<c:if test="${message != null}">
    <jsp:include page="/components/toast.jsp"/>
</c:if>
<jsp:include page="/components/modal.jsp"/>
<jsp:include page="/admin/header.jsp"/>

<div class="row">
    <jsp:include page="/admin/sidebar.jsp"/>
    <div class="col-10 offset-2">
        <div class="row m-1">
            <h2>Manage Reviews</h2>
        </div>

        <div class="row px-4">
            <div class="card shadow p-0 mb-5 bg-white rounded">
                <div class="full-height">
                    <div class="full-height-scroll">
                        <table class="table table-sm" style="position: relative; width: 700px">
                            <thead>
                            <tr>
                                <th scope="col" class="sticky-header">#</th>
                                <th scope="col" class="sticky-header">Id</th>
                                <th scope="col" class="sticky-header">Headline</th>
                                <th scope="col" class="sticky-header">Book</th>
                                <th scope="col" class="sticky-header">Customer</th>
                                <th scope="col" class="sticky-header" style="align-content: end; width: 200px;">Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="review" varStatus="status" items="${reviewsList}">
                                <tr>
                                    <th scope="row">${status.index + 1}</th>
                                    <th>${review.reviewId}</th>
                                    <th>${review.headline}</th>
                                    <th>${review.bookByBookId.title}</th>
                                    <th>${review.customerByCustomerId.fullName}</th>
                                    <th>
                                        <button type="button" class="btn btn-danger btn-sm" data-toggle="modal"
                                                onclick="deleteReview(${review.reviewId}, '')" data-target="#exampleModal">
                                            Delete
                                            <i class="far fa-trash-alt"></i>
                                        </button>
                                    </th>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    function deleteReview(id, name) {
        document.getElementById("url").action = "/admin/delete_review"

        const reviewId = document.getElementById("id")
        reviewId.value = id
        reviewId.name= "reviewId"
        const title = document.getElementsByClassName("modal-title")[0]
        title.innerText = "Delete review " + name;
        const body = document.getElementsByClassName("modal-body")[0]
        body.innerText="Do you want to delete this review?";
    }
</script>
</body>
</html>