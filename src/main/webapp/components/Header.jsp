<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 10/19/2021
  Time: 6:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<fmt:setLocale value="en_US"/>
<c:set var="cart" value="${sessionScope['cart']}"/>
<header id="site-header" class="site-header__v4">
  <div class="masthead">
    <div class="bg-white">
      <div class="container py-3">
        <div class="d-flex align-items-center position-relative flex-wrap">
          <div class="site-branding pr-md-7 mx-auto mx-md-0">
            <a href="/" class="d-block mb-1">
              <img src="/assets/img/icons/books.png" alt="logo" class="logo" style="max-height: 100px">
            </a>
          </div>
          <div class="site-navigation mr-auto d-none d-xl-block">
            <ul class="nav">
              <li class="nav-item dropdown">
                <a id="homeDropdownInvoker" href="/"
                   class=" nav-link link-black-100 mx-3 px-0 py-3 font-weight-medium d-flex align-items-center"
                   aria-haspopup="true" aria-expanded="false" data-unfold-event="hover"
                   data-unfold-target="#homeDropdownMenu" data-unfold-type="css-animation"
                   data-unfold-duration="200" data-unfold-delay="50"
                   data-unfold-hide-on-scroll="true" data-unfold-animation-in="slideInUp"
                   data-unfold-animation-out="fadeOut">

                </a>

              </li>
            </ul>
          </div>
          <div class="d-none d-md-flex align-items-center mt-3 mt-md-0 ml-md-auto">

            <a href="mailto:info@bookworm.com" class="mr-4 mb-4 mb-md-0">
              <div class="d-flex align-items-center text-dark font-size-2 text-lh-sm">
                <i class="far fa-question-circle font-size-5 mt-2 mr-1"></i>
                <div class="ml-2">
                  <span class="text-secondary-gray-1090 font-size-1">info@bookworm.com</span>
                  <div class="h6 mb-0">Any questions</div>
                </div>
              </div>
            </a>


            <a href="tel:+123456789">
              <div class="d-flex align-items-center text-dark font-size-2 text-lh-sm">
                <i class="fas fa-mobile-alt font-size-5 mt-2 mr-1"></i>
                <div class="ml-2">
                  <span class="text-secondary-gray-1090 font-size-1">+123456789</span>
                  <div class="h6 mb-0">Call toll-free</div>
                </div>
              </div>
            </a>

          </div>
        </div>
      </div>
    </div>
    <div class="mb-4">
      <div class="container">
        <div class="d-md-flex position-relative">
          <div
                  class="offcanvas-toggler align-self-center mr-md-5 d-xl-none d-flex d-md-block align-items-center">
            <a id="sidebarNavToggler2" href="javascript:;" role="button" class="cat-menu text-dark"
               aria-controls="sidebarContent2" aria-haspopup="true" aria-expanded="false"
               data-unfold-event="click" data-unfold-hide-on-scroll="false"
               data-unfold-target="#sidebarContent2" data-unfold-type="css-animation"
               data-unfold-overlay='{
                                    "className": "u-sidebar-bg-overlay",
                                    "background": "rgba(0, 0, 0, .7)",
                                    "animationSpeed": 100
                                }' data-unfold-animation-in="fadeInLeft" data-unfold-animation-out="fadeOutLeft"
               data-unfold-duration="100">
              <svg width="20px" height="18px">
                <path fill-rule="evenodd" fill="rgb(0, 0, 0)"
                      d="M-0.000,-0.000 L20.000,-0.000 L20.000,2.000 L-0.000,2.000 L-0.000,-0.000 Z" />
                <path fill-rule="evenodd" fill="rgb(0, 0, 0)"
                      d="M-0.000,8.000 L15.000,8.000 L15.000,10.000 L-0.000,10.000 L-0.000,8.000 Z" />
                <path fill-rule="evenodd" fill="rgb(0, 0, 0)"
                      d="M-0.000,16.000 L20.000,16.000 L20.000,18.000 L-0.000,18.000 L-0.000,16.000 Z" />
              </svg>
              <span class="ml-3">Browse categories</span>
            </a>
            <ul class="nav d-md-none ml-auto">
              <li class="nav-item">

                <a id="sidebarNavToggler9" href="javascript:;" role="button"
                   class="px-2 nav-link h-primary" aria-controls="sidebarContent9"
                   aria-haspopup="true" aria-expanded="false" data-unfold-event="click"
                   data-unfold-hide-on-scroll="false" data-unfold-target="#sidebarContent9"
                   data-unfold-type="css-animation" data-unfold-overlay='{
                                            "className": "u-sidebar-bg-overlay",
                                            "background": "rgba(0, 0, 0, .7)",
                                            "animationSpeed": 500
                                        }' data-unfold-animation-in="fadeInRight"
                   data-unfold-animation-out="fadeOutRight" data-unfold-duration="500">
                  <i class="far fa-user"></i>
                </a>

              </li>
            </ul>
          </div>

          <div id="basicsAccordion" class="mr-5 d-none d-xl-block">

            <div class="position-relative">
              <div class="bg-dark py-3 px-5 card-collapse" id="basicsHeadingOne">
                <button type="button"
                        class="btn btn-link btn-block p-0 d-flex align-items-center card-btn"
                        data-toggle="collapse" data-target="#basicsCollapseOne" aria-expanded="true"
                        aria-controls="basicsCollapseOne">
                  <svg width="20px" height="18px">
                    <path fill-rule="evenodd" fill="rgb(255, 255, 255)"
                          d="M-0.000,-0.000 L20.000,-0.000 L20.000,2.000 L-0.000,2.000 L-0.000,-0.000 Z" />
                    <path fill-rule="evenodd" fill="rgb(255, 255, 255)"
                          d="M-0.000,8.000 L15.000,8.000 L15.000,10.000 L-0.000,10.000 L-0.000,8.000 Z" />
                    <path fill-rule="evenodd" fill="rgb(255, 255, 255)"
                          d="M-0.000,16.000 L20.000,16.000 L20.000,18.000 L-0.000,18.000 L-0.000,16.000 Z" />
                  </svg><!--Icon short svg-->
                  <span class="ml-3 text-white">Browse categories</span>
                  <i class="fas fa-chevron-down ml-5 text-white font-size-2"></i>
                </button>
              </div>
              <div id="basicsCollapseOne"
                   class="z-index-2 bg-white collapse position-absolute right-0 left-0 border"
                   aria-labelledby="basicsHeadingOne" data-parent="#basicsAccordion" style="z-index: 100">
                <div class="card-body p-0" >
                  <ul class="list-unstyled vertical-menu position-relative mb-0" >
                    <c:set var="count" value="0"/>
                    <c:forEach items="${categoriesList}" var="category">
                      <c:if test="${count < 7 }">
                        <li>
                          <a href="/view_category?id=${category.categoryId}&page=1"
                             class="dropdown-nav-link dropdown-toggle text-dark d-flex align-items-center border-bottom">
                            <div class="width-30 mr-2 text-lh-sm"></div>
                            <div class="mr-auto">${category.name}</div>
                          </a>
                        </li>
                        <c:set var="count" value="${count + 1}"/>
                      </c:if>
                    </c:forEach>

                  </ul>
                </div>
              </div>
            </div>

          </div>

          <div
                  class="site-search ml-xl-0 ml-md-auto w-r-100 flex-grow-1 mr-md-5 mt-2 mt-md-0 py-2 py-md-0">
            <form class="form-inline my-2 my-xl-0" method="get" action="/search">
              <div class="input-group w-100">
                <div class="input-group-prepend d-none d-xl-block z-index-2">
                  <select
                          class="d-none d-lg-block custom-select pr-7 pl-4 rounded-0 height-5 shadow-none text-dark"
                          id="inputGroupSelect01" name="category">
                    <option value="" selected>All Categories</option>
                    <c:forEach items="${categoriesList}" var="category">
                      <option value="${category.categoryId}">${category.name}</option>
                    </c:forEach>
                  </select>
                </div>
                <input type="hidden" name="page" value="1" />
                <input type="text" class="form-control border-right-0 px-3"
                       placeholder="Search for books by keyword"
                       aria-label="Amount (to the nearest dollar)" name="q">
                <div class="input-group-append border-left">
                  <button class="btn btn-dark px-3 rounded-0 py-2" type="submit"><i
                          class="mx-1 fas fa-search "></i></button>
                </div>
              </div>
            </form>
          </div>
          <ul class="d-none d-md-flex nav align-self-center">

            <a id="sidebarNavToggler" href="/profile" role="button" class="nav-link text-dark"
               aria-controls="sidebarContent" aria-haspopup="true" aria-expanded="false"
               data-unfold-event="click" data-unfold-hide-on-scroll="false"
               data-unfold-target="#sidebarContent" data-unfold-type="css-animation"
               data-unfold-overlay='{
                                        "className": "u-sidebar-bg-overlay",
                                        "background": "rgba(0, 0, 0, .7)",
                                        "animationSpeed": 500
                                    }' data-unfold-animation-in="fadeInRight" data-unfold-animation-out="fadeOutRight"
               data-unfold-duration="500">
              <i class="fas fa-user-alt font-size-10"></i>
            </a>

            </li>
            <li class="nav-item">

              <a id="sidebarNavToggler1" href="/view_cart" role="button"
                 class="nav-link pr-0 text-dark position-relative" aria-controls="sidebarContent1"
                 aria-haspopup="true" aria-expanded="false" data-unfold-event="click"
                 data-unfold-hide-on-scroll="false" data-unfold-target="#sidebarContent1"
                 data-unfold-type="css-animation" data-unfold-overlay='{
                                        "className": "u-sidebar-bg-overlay",
                                        "background": "rgba(0, 0, 0, .7)",
                                        "animationSpeed": 500
                                    }' data-unfold-animation-in="fadeInRight" data-unfold-animation-out="fadeOutRight"
                 data-unfold-duration="500">

                                    <span
                                            class="position-absolute bg-dark width-16 height-16 rounded-circle
                                            d-flex align-items-center justify-content-center text-white font-size-n9 left-0">
                                      <c:if test="${cart == null or cart.totalItems == 0}">
                                        0
                                      </c:if>
                                      <c:if test="${cart != null and cart.totalItems > 0}">
                                        ${cart.totalItems}
                                      </c:if>
                                    </span>
                <i class="text-gray-400 fad fa-shopping-cart font-size-10"></i>
                <span class="d-none d-xl-inline h6 mb-0 ml-1">
                  <c:if test="${cart != null and cart.totalItems > 0}">
                    <fmt:formatNumber value="${cart.totalAmount}" type="currency"/>
                  </c:if>
                </span>
              </a>
            </li>
            <c:if test="${loggedCustomer != null}">
            <li class="nav-item"><a href="/logout" class="nav-link text-dark"><i
                    class="fad fa-sign-out-alt font-size-10"></i></a></li>
            <li class="nav-item">
            </c:if>
          </ul>
        </div>
      </div>
    </div>
  </div>
</header>
