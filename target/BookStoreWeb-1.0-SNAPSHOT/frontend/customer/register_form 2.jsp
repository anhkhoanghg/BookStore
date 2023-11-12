<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <jsp:include page="/import.jsp"/>
    <link href="/css/register.css" rel="stylesheet" type="text/css">
</head>
<body>
    <main>
        <div class="container" id="wrapper">
            <div class="form-container sign-up-container">
                <form action="/register_account" method="post">
                    <h3>Create Account</h3>


                    <input type="text" name="fullName" placeholder="Name" />
                    <input type="email" name="email" placeholder="Email" />
                    <input type="password" name="password" placeholder="Password" />
                    <div class="mt-3 custom-control custom-checkbox" style="width: 100%;">
                        <input type="checkbox" class=" text-left custom-control-input" id="customCheckSignUp" name="showPassUp">
                        <label class="float-left custom-control-label" for="customCheckSignUp" >Hide Password</label>
                    </div>

                    <button class="mt-4 mb-3">Sign Up</button>
<%--                    <div class="pb-2 d-flex align-content-center justify-content-around">--%>
<%--                        <span class="under-line mr-3"></span>--%>
<%--                        <span>OR</span>--%>
<%--                        <span class="under-line ml-3"></span>--%>
<%--                    </div>--%>
<%--                    <div class="d-flex justify-content-around">--%>
<%--                        <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>--%>
<%--                        <a href="#" class="social mx-3"><i class="fab fa-google-plus-g"></i></a>--%>
<%--                        <a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>--%>
<%--                    </div>--%>
                </form>
            </div>
            <div class="form-container sign-in-container">
                <form action="/login" method="post">
                    <h3 class="mb-4">Sign in</h3>

                    <input type="email" name="email" placeholder="Email" />
                    <input type="password" name="password" placeholder="Password" />
                    <div class="mt-3 custom-control custom-checkbox" style="width: 100%;">
                        <input type="checkbox" class=" text-left custom-control-input" id="customCheckSignIn" name="showPassIn">
                        <label class="float-left custom-control-label" for="customCheckSignIn" >Hide Password</label>
                    </div>

                    <button type="submit" class="mt-4 mb-3">Sign In</button>
<%--                    <div class="pb-2 d-flex align-content-center justify-content-around">--%>
<%--                        <span class="under-line mr-3"></span>--%>
<%--                        <span>OR</span>--%>
<%--                        <span class="under-line ml-3"></span>--%>
<%--                    </div>--%>
<%--                    <div class="d-flex justify-content-around mb-3">--%>
<%--                        <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>--%>
<%--                        <a href="#" class="social mx-3"><i class="fab fa-google-plus-g"></i></a>--%>
<%--                        <a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>--%>
<%--                    </div>--%>
<%--                    <a href="#">Forgot your Password?</a>--%>
                </form>
            </div>
            <div class="overlay-container">
                <div class="overlay">
                    <div class="overlay-panel overlay-left">
                        <h1>Welcome Back!</h1>
                        <p>Shop Update many book ...........</p>
                        <button class="ghost mt-3" id="signIn">Sign In</button>
                    </div>
                    <div class="overlay-panel overlay-right">
                        <h1>Hello, Friend!</h1>
                        <p>Enter your personal details and start journey with us</p>
                        <button class="ghost mt-3" id="signUp">Sign Up</button>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="/js/register.js"></script>
</body>
</html>
