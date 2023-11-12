
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Manage Categories</title>
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
                    <h2>Manage Categories</h2>
                </div>
                <div class="row d-flex mb-3">
                    <div class="pl-4">
                        <a href="/admin/create_category">
                            <button type="submit" class="btn btn-primary"><i class="fas fa-plus"></i> Create new category</button>
                        </a>
                    </div>
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
                                        <th scope="col" class="sticky-header">Name</th>
                                        <th scope="col" class="sticky-header" style="align-content: end">Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="category" varStatus="status" items="${categoriesList}">
                                        <tr>
                                            <th scope="row">${status.index + 1}</th>
                                            <th>${category.categoryId}</th>
                                            <th>${category.name}</th>
                                            <th>
                                                <a href="/admin/edit_category?id=${category.categoryId}">
                                                    <button type="button"  class="btn btn-primary btn-sm">Edit <i class="far fa-edit"></i></button>
                                                </a>
                                                <button type="button" class="btn btn-danger btn-sm" data-toggle="modal"
                                                        onclick="deleteCategory(${category.categoryId}, '${category.name}')" data-target="#exampleModal">
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
            function deleteCategory(id, name) {
                document.getElementById("url").action = "/admin/delete_category"

                const categoryId = document.getElementById("id")
                categoryId.value = id
                categoryId.name= "categoryId"
                const title = document.getElementsByClassName("modal-title")[0]
                title.innerText = "Delete category " + name;
                const body = document.getElementsByClassName("modal-body")[0]
                body.innerText="Do you want to delete this category?";
            }
        </script>
    </body>
</html>