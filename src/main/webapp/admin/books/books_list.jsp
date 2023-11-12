
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page buffer="none" %>
<html>
<head>
    <title>Manage Book</title>
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
            <h2>Manage Books</h2>
        </div>
        <div class="row d-flex mb-3">
            <div class="pl-4">
                <a href="/admin/new_book">
                    <button type="submit" class="btn btn-primary"> <i class="fas fa-plus"></i> Add new book</button>
                </a>
            </div>
        </div>
        <div class="row px-4">
            <div class="card shadow p-0 mb-5 bg-white rounded">
                <div class="full-height">
                    <div class="full-height-scroll">
                        <table class="table table-sm" style="position: relative; width: 1350px">
                            <thead>
                            <tr>
                                <th scope="col" class="sticky-header">#</th>
                                <th scope="col" class="sticky-header">Id</th>
                                <th scope="col" class="sticky-header">Image</th>
                                <th scope="col" class="sticky-header">Title</th>
                                <th scope="col" class="sticky-header">Author</th>
                                <th scope="col" class="sticky-header">Category</th>
                                <th scope="col" class="sticky-header">Price</th>
                                <th scope="col" class="sticky-header">Last Updated</th>
                                <th scope="col" class="sticky-header" style="align-content: flex-end">Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="book" varStatus="status" items="${booksList}">
                                <tr>
                                    <th class="align-middle" scope="row">${status.index + 1}</th>
                                    <th class="align-middle">${book.bookId}</th>
                                    <th class="align-middle">
                                        <img src="data:image/jpg;base64,${book.base64Image}" style="height: 84px;width: auto;"/>
                                    </th>
                                    <th class="align-middle line-limit" style="width: 225px">${book.title}</th>
                                    <th class="align-middle">${book.author}</th>
                                    <th class="align-middle" style="width: 120px">${book.categoryByCategoryId.name }</th>
                                    <th class="align-middle">${book.price}</th>
                                    <th class="align-middle" style="width: 180px">${book.lastUpdateTime}</th>

                                    <th class="align-middle">
                                        <a href="/admin/edit_book?id=${book.bookId}">
                                            <button type="button"  class="btn btn-primary btn-sm">Edit <i class="far fa-edit"></i></button>
                                        </a>
                                        <button type="button" class="btn btn-danger btn-sm" data-toggle="modal"
                                                onclick="deleteBook(${book.bookId}, '${book.title}')" data-target="#exampleModal">
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
        <div class="row px-4">
            <ul class="pagination">
                <c:if test="${page != 1}">
                    <li class="page-item">
                        <a class="page-link" href="/admin/list_books?page=${page - 1}">Previous</a>
                    </li>
                </c:if>
                <c:forEach var="i" begin="1" end="${numOfPages}">
                    <c:if test="${page == i}">
                        <li class="page-item active">
                            <a class="page-link" href="/admin/list_books?page=${i}">${i}</a>
                        </li>
                    </c:if>
                    <c:if test="${page != i}">
                        <li class="page-item">
                            <a class="page-link" href="/admin/list_books?page=${i}">${i}</a>
                        </li>
                    </c:if>
                </c:forEach>
                <c:if test="${page != numOfPages && numOfPages != 0}">
                    <li class="page-item">
                        <a class="page-link" href="/admin/list_books?page=${page + 1}">Next</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</div>
<script type="text/javascript">
    function deleteBook(id, bookTitle) {
        document.getElementById("url").action = "/admin/delete_book"

        const bookId = document.getElementById("id")
        bookId.value = id
        bookId.name = "bookId"
        const title = document.getElementsByClassName("modal-title")[0]
        title.innerText ="Delete book named "+ bookTitle ;
        const body = document.getElementsByClassName("modal-body")[0]
        body.innerText="Do you want to delete this book?";
    }
</script>
</body>
</html>