<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <title>Search Result</title>


    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="shortcut icon" href="/assets/img/icons/books.ico">
    <jsp:include page="/importCss.jsp" />

</head>
<body>
<%@include file="/components/Header.jsp"%>

<section class="site-search-key">
    <div class="container">
        <div class="row">
            <div class="filter-status d-flex align-items-center justify-content-lg-start text-uppercase mb-lg-5 col-lg-2">

                <i class="pl-3 fas fa-filter mr-3"></i>
                <div>
                    Filter Search
                </div>
            </div>
            <div class="shop-control-bar d-lg-flex justify-content-between align-items-center mb-5 text-center text-md-left ml-5 col-lg-9">
                <div class="shop-control-bar__left mb-4 m-lg-0 pl-10">
                    <p class="ecommerce-result-count m-0">
                        <c:if test="${numOfBook < limit }">
                            Showing ${numOfBook} in ${numOfBook} results
                        </c:if>
                        <c:if test="${numOfBook >= limit }">
                            Showing ${limit} in ${numOfBook} results
                        </c:if>
                    </p>
                </div>
                <div class="shop-control-bar__right d-md-flex align-items-center">
                    <form class="ecommerce-ordering mb-4 m-md-0" method="get">

                        <!--Sortting Default by prices or ....-->
                    </form>
                    <form class="number-of-items ml-md-4 mb-4 m-md-0 d-none d-xl-block" method="get">
                        <!--Show Number Product 20 25 30 100...-->


                    </form>

                    <ul class="nav nav-tab ml-lg-4 justify-content-center justify-content-md-start ml-md-auto" id="pills-tab" role="tablist">

                        <li class="nav-item border">
                            <a class="nav-link p-0 height-38 width-38 justify-content-center d-flex align-items-center active" id="pill-list-tab" data-toggle="pill" href="#pill-list" role="tab" aria-controls="pill-list" aria-selected="false">
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="23px" height="17px">
                                    <path fill-rule="evenodd" fill="rgb(25, 17, 11)" d="M-0.000,0.000 L3.000,0.000 L3.000,3.000 L-0.000,3.000 L-0.000,0.000 Z"></path>
                                    <path fill-rule="evenodd" fill="rgb(25, 17, 11)" d="M7.000,0.000 L23.000,0.000 L23.000,3.000 L7.000,3.000 L7.000,0.000 Z"></path>
                                    <path fill-rule="evenodd" fill="rgb(25, 17, 11)" d="M-0.000,7.000 L3.000,7.000 L3.000,10.000 L-0.000,10.000 L-0.000,7.000 Z"></path>
                                    <path fill-rule="evenodd" fill="rgb(25, 17, 11)" d="M7.000,7.000 L23.000,7.000 L23.000,10.000 L7.000,10.000 L7.000,7.000 Z"></path>
                                    <path fill-rule="evenodd" fill="rgb(25, 17, 11)" d="M-0.000,14.000 L3.000,14.000 L3.000,17.000 L-0.000,17.000 L-0.000,14.000 Z"></path>
                                    <path fill-rule="evenodd" fill="rgb(25, 17, 11)" d="M7.000,14.000 L23.000,14.000 L23.000,17.000 L7.000,17.000 L7.000,14.000 Z"></path>
                                </svg>
                                <!--SVG single list images-->
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="row">

            <div class="col-lg-3 filter-product d-flex  flex-column">

                <div id="widgetAccordion">
                    <div id="ecommerce_product_categories-2" class="widget px-5 py-5 mr-lg-6 m-sm-2 border ecommerce widget_product_categories">
                        <div id="filterWidget" class="widget-head">
                            <a class="d-flex align-items-center justify-content-between text-dark" href="#" data-toggle="collapse" data-target="#widgetCollapseOne" aria-expanded="true" aria-controls="widgetCollapseOne">
                                <h3 class="widget-title mb-0 font-weight-medium font-size-3">Categories</h3>
                                +
                            </a>
                        </div>
                        <div id="widgetCollapseOne" class="mt-3 widget-content collapse show" aria-labelledby="filterWidget1" data-parent="#widgetAccordion">
                            <ul class="product-categories">
                                <c:forEach items="${categoriesList}" var="category">
                                    <li class="cat-item cat-item-69 cat-parent">
                                        <a href="/search?category=${category.categoryId}&q=${q}&page=1">${category.name}</a>
                                    </li>
                                </c:forEach>
                            </ul>

                        </div>
                    </div>

                </div>
            </div>
            <!--Get categories Product filter to Search-->
            <div class="col-lg-9 content-area">
                <div class="tab-content" id="pills-tabContent">

                    <div class="tab-pane fade show active" id="pill-list" role="tabpanel" aria-labelledby="pill-list-tab">

                        <ul class="products list-unstyled mb-6">
                            <c:forEach items="${result}" var="book">
                                <li class="product product__list">
                                    <div class="product__inner overflow-hidden p-3 p-md-4d875">
                                        <div class="ecommerce-LoopProduct-link ecommerce-loop-product__link row position-relative">
                                            <div class="col-md-auto ecommerce-loop-product__thumbnail mb-3 mb-md-0">
                                                <a href="/view_book?id=${book.bookId}" class="d-block">
                                                    <img src="data:image/jpg;base64,${book.base64Image}" style="max-width: 250px; max-height: 250px; width: auto; height: auto;"
                                                         class="img-fluid d-block mx-auto attachment-shop_catalog size-shop_catalog wp-post-image img-fluid"
                                                         alt="image-description">
                                                </a>
                                            </div>
                                            <div class="col-md ecommerce-loop-product__body product__body pt-3 bg-white mb-3 mb-md-0">
                                                <div class="text-uppercase font-size-1 mb-1 text-truncate">
                                                    <a href="#">Paperback</a>
                                                </div>
                                                <h2 class="ecommerce-loop-product__title product__title h6 text-lh-md mb-1 crop-text-2 h-dark">
                                                    <a href="#" tabindex="0">${book.title}</a>
                                                </h2>
                                                <div class="font-size-2  mb-2 text-truncate">
                                                    <a href="#" class="text-gray-700">${book.author}</a>
                                                </div>
                                                <p class="font-size-2 mb-2 crop-text-2">
                                                        ${book.description}
                                                </p>
                                                <div class="price d-flex align-items-center font-weight-medium font-size-3">
                                                    <span class="ecommerce-Price-amount amount"><fmt:formatNumber value="${book.price}" type="currency"/></span>
                                                </div>
                                            </div>



                                            <div class="col-md-auto d-flex align-items-center">
                                                <a href="/add_to_cart?book_id=${book.bookId}"
                                                   class="text-uppercase text-dark h-dark font-weight-medium mr-4 "
                                                   data-toggle="tooltip" data-placement="right" title="" data-original-title="ADD TO CART">
                                                    <span class="product-add-cart">ADD TO CART</span>
                                                    <span class="product-add-cart-icon font-size-4">
                                                        <i class="fas fa-shopping-bag "></i>
                                                    </span>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </li><!--End Product items-->
                            </c:forEach>


                        </ul><!---Dash Product type List--> <!---Render List item here-->

                    </div><!--Tab Pills List-->
                </div>

                <nav aria-label="Page Navigation">
                    <ul class="pagination pagination__custom justify-content-md-center flex-nowrap flex-md-wrap overflow-auto overflow-md-visble">
                        <c:if test="${page != 1}">
                            <li class="flex-shrink-0 flex-md-shrink-1 page-item">
                                <a class="page-link" href="/search?category=${category}&q=${q}&page=${page - 1}">
                                    Previous
                                </a>
                            </li>
                        </c:if>
                        <c:forEach var="i" begin="1" end="${numOfPages}">
                            <c:if test="${page == i}">
                                <li class="flex-shrink-0 flex-md-shrink-1 page-item active">
                                    <a class="page-link" href="/search?category=${category}&q=${q}&page=${i}">
                                            ${i}
                                    </a>
                                </li>
                            </c:if>
                            <c:if test="${page != i}">
                                <li class="flex-shrink-0 flex-md-shrink-1 page-item ">
                                    <a class="page-link" href="/search?category=${category}&q=${q}&page=${i}">
                                            ${i}
                                    </a>
                                </li>
                            </c:if>
                        </c:forEach>
                        <c:if test="${page != numOfPages && numOfPages != 0}">
                            <li class="flex-shrink-0 flex-md-shrink-1 page-item active">
                                <a class="page-link" href="/search?category=${category}&q=${q}&page=${page + 1}">
                                    Next
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </div><!--ENd column-->
            <!--Product Show-->
        </div><!--ENd ROW-->
    </div><!--End container-->

</section>
<!--End Result search-->

<%@include file="/components/Footer.jsp"%>

<jsp:include page="/importLib.jsp"/>

</body>
</html>