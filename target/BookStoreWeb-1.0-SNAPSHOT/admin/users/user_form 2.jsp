
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>
            <c:if test="${user.userId != null}">Edit user</c:if>
            <c:if test="${user.userId == null}">Create new user</c:if>
        </title>
        <jsp:include page="/import.jsp"/>
        <link href="/css/global.css" rel="stylesheet" type="text/css">
        <link href="/css/full_height_scroll.css" rel="stylesheet" type="text/css">
        <link href="/css/icon.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <c:if test="${message != null}">
            <jsp:include page="/components/toast.jsp"/>
        </c:if>
        <jsp:include page="/admin/header.jsp"/>
        <div class="container-fluid p-0">
            <div class="row">
                <jsp:include page="/admin/sidebar.jsp"/>
                <div class="col-10 offset-2">
                    <div class="row m-1">
                        <c:if test="${user.userId != null}"><h2>Edit user</h2></c:if>
                        <c:if test="${user.userId == null}"><h2>Create new user</h2></c:if>
                    </div>
                    <c:if test="${user.userId != null}">
                    <form class="w-50" action="/admin/edit_user" method="post">
                    <input type="hidden" value="${user.userId}" name="userId"/>
                    </c:if>
                    <c:if test="${user.userId == null}"><form class="w-50" action="/admin/create_user" method="post"></c:if>
                        <div class="form-group">
                            <label for="fullName">Full name</label>
                            <input type="text" class="form-control" id="fullName" name="fullName"
                                   aria-describedby="fullNameHelp" value="${user.fullName}" placeholder="Enter your name"/>
                        </div>
                        <div class="form-group">
                            <label for="email">Email address</label>
                            <input type="email" class="form-control" id="email" name="email"
                                   aria-describedby="emailHelp" value="${user.email}" placeholder="Enter email"/>
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" class="form-control" id="password" name="password"
                                   value="${user.password}" placeholder="Password" >
                        </div>
                        <button type="submit" class="btn btn-primary" onclick="this.form.submit();this.disabled = true;">
                            <c:if test="${user.userId != null}">Edit</c:if>
                            <c:if test="${user.userId == null}">Create</h2></c:if>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>