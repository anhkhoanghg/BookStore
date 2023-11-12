<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="row " style="position: sticky; position: -webkit-sticky; top: 0; z-index: 3">
    <div class="container-fluid bg-light" >
        <div class="container-fluid">
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <a class="navbar-brand" href="#"><img src="/images/logo.jpeg" height="50" width="auto"/> Online Book Store</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" 
                        aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ml-auto mr-0">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" 
                               aria-haspopup="true" aria-expanded="false">
                                Welcome, <c:out value="${sessionScope.userEmail}"/>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item" href="/admin/logout">Logout</a>
                                <a class="dropdown-item" href="#">Another action</a>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
    </div>
</div>