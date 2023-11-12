
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page buffer="none" %>
<html>
<head>
    <title>
        <c:if test="${book.bookId != null}">Edit book</c:if>
        <c:if test="${book.bookId == null}">Create new book</c:if>
    </title>
    <jsp:include page="/import.jsp"/>
    <link href="/css/global.css" rel="stylesheet" type="text/css"/>
    <link href="/css/full_height_scroll.css" rel="stylesheet" type="text/css"/>
    <link href="/css/icon.css" rel="stylesheet" type="text/css"/>
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
                <c:if test="${book.bookId != null}"><h2>Edit book</h2></c:if>
                <c:if test="${book.bookId == null}"><h2>Create new book</h2></c:if>
            </div>
            <c:if test="${book.bookId != null}"><form class="w-50" action="/admin/edit_book" method="post" enctype="multipart/form-data">
                <input type="hidden" value="${book.bookId}" name="bookId"/></c:if>
            <c:if test="${book.bookId== null}"><form class="w-50" action="/admin/create_book" method="post"enctype="multipart/form-data"></c:if>
                <div class="form-group">
                    <label for="title">Title</label>
                    <input type="text" class="form-control" id="title" name="title"
                           aria-describedby="titleHelp" value="${book.title}" placeholder="Enter title"/>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="author">Author</label>
                        <input type="text" class="form-control" id="author" name="author"
                               aria-describedby="authorHelp" value="${book.author}" />
                    </div>
                    <div class="form-group col-md-4">
                        <label for="isbn">Isbn</label>
                        <input type="text" class="form-control" id="isbn" name="isbn"
                               aria-describedby="isbnHelp" value="${book.isbn}" placeholder="Enter isbn"/>
                    </div>
                    <div class="form-group col-md-2">
                        <label for="price">Price</label>
                        <input type="text" class="form-control" id="price" name="price"
                               aria-describedby="priceHelp" value="${book.price}" />
                    </div>
                </div>
                <div class="form-row ">
                    <div class="form-group col-md-5">
                        <label for="bookImage">Book Image</label>
                        <input type="file" class="my-2" id="bookImage" name="bookImage"
                               aria-describedby="bookImageHelp"  />
                        <c:if test="${book.bookId != null}">
                            <img id="thumbnail" src="data:image/jpg;base64,${book.base64Image}"
                                 onerror="this.src='https://aimint.org/ap/wp-content/uploads/sites/18/2016/04/image-placeholder-vertical.jpg'"
                                 alt="Image preview" style="height: 200px;width: auto;"/>
                        </c:if>
                        <c:if test="${book.bookId == null}">
                            <img id="thumbnail" src="https://aimint.org/ap/wp-content/uploads/sites/18/2016/04/image-placeholder-vertical.jpg"
                                 alt="Image preview" style="height: 200px;width: auto;"/>
                        </c:if>
                    </div>
                    <div class="form-group col-md-4">
                        <label for="publishDate">Publish Date</label>
                        <input type="text" class="form-control" id="publishDate" name="publishDate"
                               aria-describedby="publishDateHelp" value="${book.publishDate}" >
                    </div>
                    <div class="form-group col-md-3">
                        <label for="category">Category</label>
                        <select id="category" name="category" class="form-control" >
                            <c:forEach items="${categoriesList}" var="category">
                                <c:if test="${category.categoryId eq book.categoryByCategoryId.categoryId}">
                                    <option value="${category.categoryId}" selected>
                                            ${category.name}
                                    </option>
                                </c:if>
                                <c:if test="${category.categoryId ne book.categoryByCategoryId.categoryId}">
                                    <option value="${category.categoryId}" >
                                            ${category.name}
                                    </option>
                                </c:if>

                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea class="form-control" id="description" name="description" rows="5"
                           aria-describedby="descriptionHelp" value="">${book.description}</textarea>
                </div>


                <button type="submit" class="btn btn-primary" onclick="this.form.submit();this.disabled = true;">
                    <c:if test="${book.bookId != null}">Edit</c:if>
                    <c:if test="${book.bookId == null}">Create</h2></c:if>
                </button>
            </form>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $('#publishDate').datepicker({
            uiLibrary: 'bootstrap4',
            format: 'yyyy-mm-dd'
        });
        $("#bookImage").change(function (){
            showImageThumbnail(this)
        })
        $('#description').editor();

    })
    function showImageThumbnail(fileInput){
        var file = fileInput.files[0];
        var reader = new FileReader();
        reader.onload = function (e) {
            $("#thumbnail").attr('src', e.target.result);
        }
        reader.readAsDataURL(file)
    }
</script>
</body>
</html>