
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Manage User</title>
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
                    <h2>Manage Users</h2>
                </div>
                <div class="row d-flex mb-3">
                    <div class="pl-4">
                        <a href="/admin/create_user">
                            <button type="submit" class="btn btn-primary"> <i class="fas fa-plus"></i> Create new user</button>
                        </a>
                    </div>
                </div>
                <div class="row px-4">
                    <div class="card shadow p-0 mb-5 bg-white rounded">
                        <div class="full-height">
                            <div class="full-height-scroll">
                                <table class="table table-sm" style="position: relative; width: 900px">
                                    <thead>
                                        <tr>
                                            <th scope="col" class="sticky-header">#</th>
                                            <th scope="col" class="sticky-header">Id</th>
                                            <th scope="col" class="sticky-header">Full Name</th>
                                            <th scope="col" class="sticky-header">Email</th>
                                            <th scope="col" class="sticky-header">Admin</th>
                                            <th scope="col" class="sticky-header" style="align-content: flex-end">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="user" varStatus="status" items="${usersList}">
                                            <tr>
                                                <th scope="row">${status.index + 1}</th>
                                                <th>${user.userId}</th>
                                                <th>${user.fullName}</th>
                                                <th>${user.email}</th>
                                                <th>
                                                    <c:choose>
                                                        <c:when test="${user.userId=='1'}">
                                                            <i class="fas fa-user-shield text-success">
                                                                Root
                                                            </i>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fas fa-times text-danger"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </th>
                                                <th>
                                                    <a href="/admin/edit_user?id=${user.userId}">
                                                        <button type="button"  class="btn btn-primary btn-sm">Edit <i class="fas fa-user-cog"></i></button>
                                                    </a>
                                                    <button type="button" class="btn btn-danger btn-sm" data-toggle="modal"
                                                            onclick="deleteUser(${user.userId}, '${user.email}')" data-target="#exampleModal">
                                                        Delete
                                                        <i class="fas fa-user-times"></i>
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
            function deleteUser(id, email) {
                document.getElementById("url").action = "/admin/delete_user"

                const userId = document.getElementById("id")
                userId.value = id
                userId.name = "userId"
                const title = document.getElementsByClassName("modal-title")[0]
                title.innerText ="Delete account "+ email ;
                const body = document.getElementsByClassName("modal-body")[0]
                body.innerText="Do you want to delete this account?";
            }
        </script>
    </body>
</html>