
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Manage Customer</title>
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
            <h2>Manage Customer</h2>
        </div>
        <div class="row px-4">
            <div class="card shadow p-0 mb-5 bg-white rounded">
                <div class="full-height">
                    <div class="full-height-scroll">
                        <table class="table table-sm" style="position: relative; width: 1200px">
                            <thead>
                            <tr>
                                <th scope="col" class="sticky-header">#</th>
                                <th scope="col" class="sticky-header">Id</th>
                                <th scope="col" class="sticky-header">Full Name</th>
                                <th scope="col" class="sticky-header">Email</th>
                                <th scope="col" class="sticky-header">City</th>
                                <th scope="col" class="sticky-header">Country</th>
                                <th scope="col" class="sticky-header">Registered Date</th>
                                <th scope="col" class="sticky-header" style="align-content: flex-end">Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="customer" varStatus="status" items="${customersList}">
                                <tr>
                                    <th scope="row">${status.index}</th>
                                    <th>${customer.customerId}</th>
                                    <th>${customer.fullName}</th>
                                    <th>${customer.email}</th>
                                    <th>${customer.city}</th>
                                    <th>${customer.country}</th>
                                    <th>${customer.registerDate}</th>
                                    <th>
                                        <button type="button" class="btn btn-danger btn-sm" data-toggle="modal"
                                                onclick="deleteCustomer(${customer.customerId}, '${customer.email}')" data-target="#exampleModal">
                                            Delete
                                            <i class="fas fa-customer-times"></i>
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
    function deleteCustomer(id, email) {
        document.getElementById("url").action = "/admin/delete_customer"

        const customerId = document.getElementById("id")
        customerId.value = id
        customerId.name = "customerId"
        const title = document.getElementsByClassName("modal-title")[0]
        title.innerText ="Delete account "+ email ;
        const body = document.getElementsByClassName("modal-body")[0]
        body.innerText="Do you want to delete this account?";
    }
</script>
</body>
</html>