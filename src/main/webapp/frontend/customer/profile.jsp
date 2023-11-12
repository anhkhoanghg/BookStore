<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <title>Your Profile</title>


    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="shortcut icon" href="/assets/img/icons/books.ico">
    <jsp:include page="/importCss.jsp" />
    <link rel="stylesheet" href="/css/profile.css">

</head>
<body>
<%@include file="/components/Header.jsp"%>

<div class="container">
    <div class="main">
        <div class="row">
            <div class="col-md-4 mt-1">
                <div class="card text-center sidebar">
                    <div class="card-body">
                        <!-- <div class="avatar rounded-circle border m-auto position-relative overflow-hidden"
                            style="width: 150px; height: 150px">
                            <input type="file" name="avatar" class="avatar-upload position-absolute">
                        </div> -->
                        <div class="mt-3 text-left">
                            <h3 class="text-center pb-2">${loggedCustomer.fullName}</h3>
                            <div class="d-flex text-center">
                                <c:if test="${msg != null}">
                                    <i>${msg}</i>
                                </c:if>
                                <c:if test="${msg == null}">
                                    <i>Manage your information for more security</i>
                                </c:if>

                            </div>
                            <hr>
                            <a href="#basic-info" class="p-2 rounded btn text-left">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                     fill="currentColor" class="bi bi-layout-text-sidebar-reverse"
                                     viewBox="0 0 16 20">
                                    <path
                                            d="M12.5 3a.5.5 0 0 1 0 1h-5a.5.5 0 0 1 0-1h5zm0 3a.5.5 0 0 1 0 1h-5a.5.5 0 0 1 0-1h5zm.5 3.5a.5.5 0 0 0-.5-.5h-5a.5.5 0 0 0 0 1h5a.5.5 0 0 0 .5-.5zm-.5 2.5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1 0-1h5z" />
                                    <path
                                            d="M16 2a2 2 0 0 0-2-2H2a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2zM4 1v14H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h2zm1 0h9a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H5V1z" />
                                </svg> Basic Info</a>
                            <a href="#contact-info" class="p-2 rounded btn text-left">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                     fill="currentColor" class="bi bi-telephone-inbound" viewBox="0 0 16 20">
                                    <path
                                            d="M15.854.146a.5.5 0 0 1 0 .708L11.707 5H14.5a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5v-4a.5.5 0 0 1 1 0v2.793L15.146.146a.5.5 0 0 1 .708 0zm-12.2 1.182a.678.678 0 0 0-1.015-.063L1.605 2.3c-.483.484-.661 1.169-.45 1.77a17.568 17.568 0 0 0 4.168 6.608 17.569 17.569 0 0 0 6.608 4.168c.601.211 1.286.033 1.77-.45l1.034-1.034a.678.678 0 0 0-.063-1.015l-2.307-1.794a.678.678 0 0 0-.58-.122l-2.19.547a1.745 1.745 0 0 1-1.657-.459L5.482 8.062a1.745 1.745 0 0 1-.46-1.657l.548-2.19a.678.678 0 0 0-.122-.58L3.654 1.328zM1.884.511a1.745 1.745 0 0 1 2.612.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.678.678 0 0 0 .178.643l2.457 2.457a.678.678 0 0 0 .644.178l2.189-.547a1.745 1.745 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.634 18.634 0 0 1-7.01-4.42 18.634 18.634 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877L1.885.511z" />
                                </svg> Contact Info</a>
                            <a href="#payment-info" class="p-2 rounded btn text-left">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                     fill="currentColor" class="bi bi-credit-card" viewBox="0 0 16 20">
                                    <path
                                            d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4zm2-1a1 1 0 0 0-1 1v1h14V4a1 1 0 0 0-1-1H2zm13 4H1v5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V7z" />
                                    <path
                                            d="M2 10a1 1 0 0 1 1-1h1a1 1 0 0 1 1 1v1a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1v-1z" />
                                </svg> Payment Info</a>
                            <a href="#password-edit" class="p-2 rounded btn text-left js__btn-password" >
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                     fill="currentColor" class="bi bi-shield-lock" viewBox="0 0 16 20">
                                    <path
                                            d="M5.338 1.59a61.44 61.44 0 0 0-2.837.856.481.481 0 0 0-.328.39c-.554 4.157.726 7.19 2.253 9.188a10.725 10.725 0 0 0 2.287 2.233c.346.244.652.42.893.533.12.057.218.095.293.118a.55.55 0 0 0 .101.025.615.615 0 0 0 .1-.025c.076-.023.174-.061.294-.118.24-.113.547-.29.893-.533a10.726 10.726 0 0 0 2.287-2.233c1.527-1.997 2.807-5.031 2.253-9.188a.48.48 0 0 0-.328-.39c-.651-.213-1.75-.56-2.837-.855C9.552 1.29 8.531 1.067 8 1.067c-.53 0-1.552.223-2.662.524zM5.072.56C6.157.265 7.31 0 8 0s1.843.265 2.928.56c1.11.3 2.229.655 2.887.87a1.54 1.54 0 0 1 1.044 1.262c.596 4.477-.787 7.795-2.465 9.99a11.775 11.775 0 0 1-2.517 2.453 7.159 7.159 0 0 1-1.048.625c-.28.132-.581.24-.829.24s-.548-.108-.829-.24a7.158 7.158 0 0 1-1.048-.625 11.777 11.777 0 0 1-2.517-2.453C1.928 10.487.545 7.169 1.141 2.692A1.54 1.54 0 0 1 2.185 1.43 62.456 62.456 0 0 1 5.072.56z" />
                                    <path
                                            d="M9.5 6.5a1.5 1.5 0 0 1-1 1.415l.385 1.99a.5.5 0 0 1-.491.595h-.788a.5.5 0 0 1-.49-.595l.384-1.99a1.5 1.5 0 1 1 2-1.415z" />
                                </svg> Change Password</a>
                            <a class="p-2 rounded btn text-left js__btn-edit" >
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                     fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 20">
                                    <path
                                            d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
                                    <path fill-rule="evenodd"
                                          d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z" />
                                </svg> Edit Profile</a>
                        </div>
                    </div>
                </div>
            </div> <!-- / .Sidebar info-->
            <div class="col-md-8 mt-1">
                <div class="js__profile-view">
                    <div id="basic-info" class="card mb-3 content">
                        <h3 class="m-3 pt-3">Basic Info</h3>
                        <div class="card-body ml-2">
                            <div class="row">
                                <div class="col-md-4">
                                    <h5>Full Name</h5>
                                </div>
                                <div class="col-md-8 text-secondary">
                                    ${loggedCustomer.fullName}
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-md-4">
                                    <h5>Email</h5>
                                </div>
                                <div class="col-md-8 text-secondary">
                                    ${loggedCustomer.email}
                                </div>
                            </div>
                        </div>
                    </div> <!-- / .Basic info-->
                    <div id="contact-info" class="card mb-3 content">
                        <h3 class="m-3">Contact Info</h3>
                        <div class="card-body ml-2">
                            <div class="row">
                                <div class="col-md-4">
                                    <h5>Phone</h5>
                                </div>
                                <div class="col-md-8 text-secondary">
                                    ${loggedCustomer.phone}
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-md-4">
                                    <h5>Address line 1</h5>
                                </div>
                                <div class="col-md-8 text-secondary">
                                    ${loggedCustomer.addressLine1}
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-md-4">
                                    <h5>Address line 2</h5>
                                </div>
                                <div class="col-md-8 text-secondary">
                                    ${loggedCustomer.addressLine2}
                                </div>
                            </div>
                        </div>
                    </div> <!-- / .Contact info-->
                    <div id="payment-info" class="card mb-3 content">
                        <h3 class="m-3">Payment Info</h3>
                        <div class="card-body ml-2">
                            <div class="row">
                                <div class="col-md-4">
                                    <h5>State</h5>
                                </div>
                                <div class="col-md-8 text-secondary">
                                    ${loggedCustomer.state}
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-md-4">
                                    <h5>City</h5>
                                </div>
                                <div class="col-md-8 text-secondary">
                                    ${loggedCustomer.city}
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-md-4">
                                    <h5>ZIP Code</h5>
                                </div>
                                <div class="col-md-8 text-secondary">
                                    ${loggedCustomer.zipcode}
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-md-4">
                                    <h5>Country</h5>
                                </div>
                                <div class="col-md-8 text-secondary">
                                    <c:if test="${loggedCustomer.country != null}">
                                        ${loggedCustomer.countryName}
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div> <!-- / .Delivery info-->
                </div>
                <form class="js__password-edit d-none" action="change_password" method="post">
                    <div id="password-edit" class="card mb-3 content">
                        <h3 class="m-3 pt-3">Password</h3>
                        <div class="card-body ml-2">
                            <div class="row">
                                <div class="col-md-4">
                                    <h5>Current Password</h5>
                                </div>
                                <div class="input-group col-md-8 text-secondary p-0">
                                    <input type="password" id="js__currPass" class="form-control js__input-pass"
                                           placeholder="Current password" aria-label="Newpass"
                                           name="currentPassword" aria-describedby="basic-addon1">
                                    <div class="input-group-prepend">
                                                <span class="input-group-text js__toggle-pass" id="basic-addon1">
                                                    <i class="fal fa-eye fa-eye-slash"></i>
                                                </span>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div class="row align-items-center">
                                <div class="col-md-4">
                                    <h5 class="mb-0">New Password</h5>
                                </div>
                                <div class="input-group col-md-8 text-secondary p-0">
                                    <input type="password" id="js__newPass" class="form-control js__input-pass"
                                           placeholder="New password" aria-label="Newpass"
                                           name="newPassword" aria-describedby="basic-addon2" value=""/>
                                    <div class="input-group-prepend">
                                                <span class="input-group-text js__toggle-pass" id="basic-addon2">
                                                    <i class="fal fa-eye fa-eye-slash"></i>
                                                </span>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div class="row align-items-center">
                                <div class="col-md-4">
                                    <h5 class="mb-0">Confirm Password</h5>
                                </div>
                                <div class="input-group col-md-8 text-secondary p-0">
                                    <input type="password" id="js__confirmPass" class="form-control js__input-pass"
                                           placeholder="Confirm password" aria-label="Confirmpass"
                                           name="confirmPassword" aria-describedby="basic-addon3" value=""/>
                                    <div class="input-group-prepend">
                                                <span class="input-group-text js__toggle-pass" id="basic-addon3">
                                                    <i class="fal fa-eye fa-eye-slash"></i>
                                                </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div> <!-- / .Password-->
                    <div class="text-center">
                        <button type="submit"
                                class="btn btn-danger btn-xl mr-4 js__btn-update-pass">Update</button>
                        <button type="button"
                                class="btn btn-outline-danger btn-xl ml-4 js__btn-cancel-pass">Cancel</button>
                    </div>
                </form>
                <form class="js__profile-edit d-none" action="/update_profile" method="post">
                    <div class="card mb-3 content">
                        <h3 class="m-3 pt-3">Basic Info</h3>
                        <div class="card-body ml-2">
                            <div class="row align-items-center">
                                <div class="col-md-4">
                                    <h5 class="mb-0">First Name</h5>
                                </div>
                                <input type="text" class="col-md-8 text-secondary form-control js__input-info"
                                       name="firstname" value="${loggedCustomer.firstname}" placeholder="First Name">
                            </div>
                            <hr>
                            <div class="row align-items-center">
                                <div class="col-md-4">
                                    <h5 class="mb-0">Last Name</h5>
                                </div>
                                <input type="text" class="col-md-8 text-secondary form-control js__input-info"
                                       name="lastname" value="${loggedCustomer.lastname}" placeholder="Last Name">
                            </div>
                            <hr>
                            <div class="row align-items-center">
                                <div class="col-md-4">
                                    <h5 class="mb-0">Email</h5>
                                </div>
                                <input type="email" class="col-md-8 text-secondary form-control js__input-info"
                                       id="exampleInputEmail1" aria-describedby="emailHelp"
                                       name="email" value="${loggedCustomer.email}" placeholder="Enter email">
                            </div>
                        </div>
                    </div> <!-- / .Basic info-->
                    <div class="card mb-3 content">
                        <h3 class="m-3">Contact Info</h3>
                        <div class="card-body ml-2">
                            <div class="row align-items-center">
                                <div class="col-md-4">
                                    <h5 class="mb-0">Phone</h5>
                                </div>
                                <input type="text" class="col-md-8 text-secondary form-control js__input-info"
                                       name="phone" value="${loggedCustomer.phone}"  placeholder="Contact number">
                            </div>
                            <hr>
                            <div class="row align-items-center">
                                <div class="col-md-4">
                                    <h5 class="mb-0">Address line 1</h5>
                                </div>
                                <input type="text" class="col-md-8 text-secondary form-control js__input-info"
                                       name="addressLine1" value="${loggedCustomer.addressLine1}" placeholder="Address Line 1">
                            </div>
                            <hr>
                            <div class="row align-items-center">
                                <div class="col-md-4">
                                    <h5 class="mb-0">Address line 2</h5>
                                </div>
                                <input type="text" class="col-md-8 text-secondary form-control js__input-info"
                                       name="addressLine2" value="${loggedCustomer.addressLine2}" placeholder="Address Line 2">
                            </div>
                        </div>
                    </div> <!-- / .Contact info-->
                    <div class="card mb-3 content">
                        <h3 class="m-3">Payment Info</h3>
                        <div class="card-body ml-2">
                            <div class="row align-items-center">
                                <div class="col-md-4">
                                    <h5 class="mb-0">State</h5>
                                </div>
                                <input type="text" class="col-md-8 text-secondary form-control js__input-info"
                                       name="state" value="${loggedCustomer.state}" placeholder="State">
                            </div>
                            <hr>
                            <div class="row align-items-center">
                                <div class="col-md-4">
                                    <h5 class="mb-0">City</h5>
                                </div>
                                <input type="text" class="col-md-8 text-secondary form-control js__input-info"
                                       name="city" value="${loggedCustomer.city}" placeholder="City">
                            </div>
                            <hr>
                            <div class="row align-items-center">
                                <div class="col-md-4">
                                    <h5 class="mb-0">ZIP Code</h5>
                                </div>
                                <input type="text" class="col-md-8 text-secondary form-control js__input-info"
                                       name="zipcode" value="${loggedCustomer.zipcode}" placeholder="88888">
                            </div>
                            <hr>
                            <div class="row align-items-center">
                                <div class="col-md-4">
                                    <h5 class="mb-0">Country</h5>
                                </div>
                                <select id="inputCountry" name="country"
                                        class="col-md-8 text-secondary form-control form-control-custom font-weight-bold mb-3">
                                    <c:forEach items="${mapCountries}" var="country">
                                        <option value="${country.value}" class="option-size-custom"
                                                <c:if test="${loggedCustomer.country eq country.value}">selected="selected"</c:if>>
                                                ${country.key}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div> <!-- / .Delivery info-->
                    <div class="text-center">
                        <button type="submit" class="btn btn-danger btn-xl mr-4 js__btn-update">Update</button>
                        <button type="button"
                                class="btn btn-outline-danger btn-xl ml-4 js__btn-cancel">Cancel</button>
                    </div>
                </form>
            </div> <!-- / .User info-->
        </div>
    </div>
</div>
<script src="/js/profile.js"></script>
<jsp:include page="/importLib.jsp"/>
<c:if test="${message != null}">
    <jsp:include page="/frontend/toast.jsp"/>
</c:if>

<%@include file="/components/Footer.jsp"%>


</body>
</html>