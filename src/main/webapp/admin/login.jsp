<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Login </title>
  <jsp:include page="/import.jsp"/>
  <link href="/css/global.css" rel="stylesheet" type="text/css"/>
  <link rel="stylesheet" href="/css/login.css" type="text/css"/>
</head>
<body>
  <div class="container-fluid d-flex align-items-center min-vh-100 py-3 py-md-0 bg-light">
    <div class="container">
      <div class="card login-card">
        <div class="row no-gutters">
          <div class="col-md-5">
            <img src="https://i2.pickpik.com/photos/379/449/110/books-library-literature-learning-thumb.jpg" alt="login" class="login-card-img">
          </div>
          <div class="col-md-7">
            <div class="card-body">
              <div class="brand-wrapper">
                <img src="/images/logo.jpeg" alt="logo" class="logo">
              </div>
              <p class="login-card-description">Sign into your account</p>
              <form action="/admin/login" method="post">
                  <div class="form-group">
                    <label for="email" class="sr-only">Email</label>
                    <input type="email" name="email" id="email" class="form-control" placeholder="Email address">
                  </div>
                  <div class="form-group mb-4">
                    <label for="password" class="sr-only">Password</label>
                    <input type="password" name="password" id="password" class="form-control" placeholder="***********">
                    <small  class="form-text text-muted my-1">${message.msg}</small>
                  </div>
                  <input class="btn btn-block login-btn mb-4" type="submit" value="Login">
                </form>
                <a href="#!" class="forgot-password-link">Forgot password?</a>
                <p class="login-card-footer-text">Don't have an account? <a href="#!" class="text-reset">Register here</a></p>
                <nav class="login-card-footer-nav">
                  <a href="#!">Terms of use.</a>
                  <a href="#!">Privacy policy</a>
                </nav>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
