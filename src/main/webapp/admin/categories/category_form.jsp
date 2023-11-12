
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
    <title>
      <c:if test="${category.categoryId != null}">Edit category</c:if>
      <c:if test="${category.categoryId == null}">Create new category</c:if>
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
            <c:if test="${category.categoryId != null}"><h2>Edit category</h2></c:if>
            <c:if test="${category.categoryId == null}"><h2>Create new category</h2></c:if>

          </div>
          <c:if test="${category.categoryId != null}">
          <form class="w-50" action="/admin/edit_category" method="post">
            <input type="hidden" value="${category.categoryId}" name="categoryId"/>
            </c:if>
            <c:if test="${category.categoryId == null}"><form class="w-50" action="/admin/create_category" method="post"></c:if>

            <div class="form-group">
              <label for="name">Category name</label>
              <input type="text" class="form-control" id="name" name="name"
                     aria-describedby="nameHelp" value="${category.name}" placeholder="Enter category name"/>
            </div>

            <button type="submit" class="btn btn-primary" onclick="this.form.submit();this.disabled = true;">
              <c:if test="${category.categoryId != null}">Edit</c:if>
              <c:if test="${category.categoryId == null}">Create</c:if>
            </button>
          </form>
        </div>
      </div>
    </div>
  </body>
</html>