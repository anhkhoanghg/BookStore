<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <title>Detail Product</title>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="shortcut icon" href="/assets/img/icons/books.ico">
    <jsp:include page="/importCss.jsp" />

</head>

<body>

<%@include file="/components/Header.jsp"%>

<section class="site-adversite space-top-3">
</section>

<section class="site-product-detail space-bottom-2">
    <div class="container">
        <div class="row space-bottom-1">
            <span class="path">Shop>${book.categoryByCategoryId.name}>${book.title}</span>
        </div>
        <div class="row space-top-2">
            <div class="content-area col-lg-8">
                <div class="row">
                    <div class="col-lg-5">
                        <div class="bg-img-hero img-fluid bg-gradient-dark-1 mb-6 mb-xl-0 ml-xl-2d75 ml-wd-11"
                             style="background-image: url(/assets/img/900x506/img1.jpg);">
                            <div class="space-top-2 space-top-xl-4 px-4 px-md-5 px-lg-7 pb-3">
                                <ul class="js-slick-carousel u-slick pl-0 mb-0"
                                    data-pagi-classes="text-center u-slick__pagination u-slick__pagination--v2 mt-6 mb-3">
                                    <li class="hero-slider">
                                        <img id="thumbnail" src="data:image/jpg;base64,${book.base64Image}"
                                             onerror="this.src='https://aimint.org/ap/wp-content/uploads/sites/18/2016/04/image-placeholder-vertical.jpg'" class="mr-xl-10 mr-wd-6 img-fluid"
                                             alt="image-description">
                                    </li>
                                </ul>
                            </div>
                        </div>

                    </div><!--End carousel Content of product-->
                    <div class="col-lg-7">

                        <div class=" px-lg-4 px-xl-6">
                            <h3 class="font-weight-bold">${book.title}</h3>
                            <div class="font-size-2 mb-4">
                                <span class="text-yellow-darker">
                                    <%@include file="/frontend/book_rating.jsp"%>
                                </span>
                                <!--Star Evaluate from data-->
                                <span class="ml-3">(5,000)</span><!--Number user use-->
                                <span class="ml-2 text-gray-600">Fierence</span>
                            </div>
                            <div class="font-size-3 mb-1">
                                ${book.description}
                            </div><!--Short description-->

                            <div class="price font-weight-medium font-size-5">
                                <span class="ecommerce-Price-amount amount">
                                    <fmt:formatNumber value="${book.price}" type="currency"/>
                                </span>
                            </div>

                            <div class="">
                                <form class="cart d-md-flex align-items-center" method="get"  action="/add_to_cart">
                                    <input type="hidden" name="book_id" value="${book.bookId}"/>
                                    <button type="submit"  class="btn btn-dark border-0 rounded-0 p-3 btn-block ml-md-4 font-size-3">Add to cart</button>
                                </form>
                            </div>
                        </div><!--ENd Content Product-->
                    </div><!--End row-->
                </div>

            </div><!--End row -->


        </div><!--ENd row space with some content-->
        <div class="ecommerce-tabs wc-tabs-wrapper mb-10 row">
            <!-- Nav Classic -->
            <ul class="col-lg-4 col-xl-3 pt-9 border-top d-lg-block tabs wc-tabs nav justify-content-lg-center flex-nowrap flex-lg-wrap overflow-auto overflow-lg-visble" id="pills-tab" role="tablist">
                <li class="flex-shrink-0 flex-lg-shrink-1 nav-item mb-3">
                    <a class="py-1 d-inline-block nav-link font-weight-medium active" id="#fill-tab-description" data-toggle="pill" href="#fill-tab-description" role="tab" aria-controls="fill-tab-description" aria-selected="true">
                        Description
                    </a>
                </li> <!--nav tab description-->

                <li class="flex-shrink-0 flex-lg-shrink-1 nav-item mb-3">
                    <a class="py-1 d-inline-block nav-link font-weight-medium" id="#fill-tab-product-detail" data-toggle="pill" href="#fill-tab-product-detail" role="tab" aria-controls="fill-tab-product-detail" aria-selected="false">
                        Product Details
                    </a>
                </li> <!--Nav product detail-->

                <li class="flex-shrink-0 flex-lg-shrink-1 nav-item mb-3">
                    <a class="py-1 d-inline-block nav-link font-weight-medium" id="#fill-user-review" data-toggle="pill" href="#fill-user-review" role="tab" aria-controls="fill-user-review" aria-selected="false">
                        Reviews (4)
                    </a>
                </li><!--End review User about Product-->
            </ul>
            <!-- End Nav Classic nav will have update 4 navigation -->

            <!-- Tab each Content  by bs4-->
            <div class="tab-content col-lg-8 col-xl-9 border-top" id="pills-tabContent">

                <div class="ecommerce-Tabs-panel panel entry-content wc-tab tab-pane fade border-left pl-4 pt-4 pl-lg-6 pt-lg-6 pl-xl-9 pt-xl-9 active show" id="fill-tab-description" role="tabpanel" aria-labelledby="fill-tab-description">
                    <!-- Mockup Block -->
                    ${book.description}
                    <!-- End Mockup Block -->
                </div> <!--End table long description-->


                <div class="ecommerce-Tabs-panel panel entry-content wc-tab tab-pane fade border-left pl-4 pt-4 pl-lg-6 pt-lg-6 pl-xl-9 pt-xl-9" id="fill-tab-product-detail" role="tabpanel" aria-labelledby="fill-tab-product-detail">
                    <!-- Mockup Block -->
                    <div class="table-responsive mb-4">
                        <table class="table table-hover table-borderless">
                            <tbody>
                            <tr>
                                <th class="px-4 px-xl-5 text-uppercase">Title: </th>
                                <td class="">${book.title}</td>
                            </tr>
                            <tr>
                                <th class="px-4 px-xl-5 text-uppercase">Author</th>
                                <td>${book.author}</td>
                            </tr>
                            <tr>
                                <th class="px-4 px-xl-5 text-uppercase">Publication date: </th>
                                <td class="customDate">${book.publishDate}</td>
                            </tr>
                            <tr>
                                <th class="px-4 px-xl-5 text-uppercase">ISBN:</th>
                                <td>${book.isbn}</td>
                            </tr>
                            <tr>
                                <th class="px-4 px-xl-5 text-uppercase">Last update time:</th>
                                <td>${book.lastUpdateTime}</td>
                            </tr>
                            <tr>
                                <th class="px-4 px-xl-5 text-uppercase">Category:</th>
                                <td>${book.categoryByCategoryId.name}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- End End Product Detail -->
                </div>

                <div class="ecommerce-Tabs-panel panel entry-content wc-tab tab-pane fade border-left pl-4 pt-4 pl-lg-6 pt-lg-6 pl-xl-9 pt-xl-9" id="fill-user-review" role="tabpanel" aria-labelledby="fill-user-review">
                    <!-- Mockup Block -->
                    <h4 class="font-size-3">Customer Reviews </h4>
                    <div class="mb-8">
                        <div class="mb-6">
                            <div class="d-flex  align-items-center mb-4">
                                <span class="font-size-15 font-weight-bold">${book.averageRating}</span>
                                <div class="ml-3 h6 mb-0">
                                    <span class="font-weight-normal">${book.reviewsByBookId.size()} reviews</span>
                                    <div class="text-yellow-darker">
                                        <%@include file="/frontend/book_rating.jsp"%>
                                    </div>
                                </div>
                            </div> <!--Will load from form and compute-->

                            <div class="d-xl-flex">
                                <button type="button" class="d-block btn btn-dark ml-xl-3 rounded-0 px-5" id="#form-write-review">Write a review</button>
                            </div>
                        </div>
                        <div class="">
                            <!-- Ratings -->
                            <ul class="list-unstyled">
                                <c:forEach var = "i" begin = "0" end = "4">
                                    <li class="py-2">
                                        <a class="row align-items-center mx-gutters-2 font-size-2" href="javascript:;">
                                            <div class="col-auto">
                                                <span class="text-dark">${5 - i} stars</span>
                                            </div>
                                            <div class="col px-0">
                                                <div class="progress bg-white-100" style="height: 7px;">
                                                    <div class="progress-bar bg-yellow-darker" role="progressbar"
                                                         style="width: ${book.ratingPercentArr[i]}%;" aria-valuenow="${book.ratingPercentArr[i]}"
                                                         aria-valuemin="0" aria-valuemax="100"></div>
                                                </div>
                                            </div>
                                            <div class="col-2">
                                                <span class="text-secondary">${book.ratingArr[i]}</span>
                                            </div>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                            <!-- End Ratings -->
                        </div>
                    </div>

                    <h4 class="font-size-3 mb-8">${book.reviewsByBookId.size()} reviews</h4>

                    <ul class="list-unstyled mb-8">
                        <c:forEach items="${book.reviewsByBookId}" var="review">
                            <li class="mb-4 pb-5 border-bottom">
                                <div class="d-flex align-items-center mb-3">
                                    <h6 class="mb-0">${review.headline}</h6>
                                    <div class="text-yellow-darker ml-3">
                                        <c:forTokens items="${review.stars}" delims="," var="star">
                                            <c:if test="${star eq 'on'}">
                                                <small class="fas fa-star"></small>
                                            </c:if>
                                        </c:forTokens>
                                    </div>
                                </div>
                                <p class="mb-4 text-lh-md">${review.comment}</p>
                                <div class="text-gray-600 mb-4">${review.customerByCustomerId.fullName}, ${review.reviewTime}</div>
                            </li>
                        </c:forEach>
                    </ul>

                    <h4 class="font-size-3 mb-4">Write a Review</h4>
                    <form action="${submitReviewLink}" id="form-write-review" method="post">
                        <input type="hidden" name="bookId" value="${book.bookId}" />
                        <input type="hidden" name="id" value="${book.bookId}" />
                        <div class="d-flex align-items-center mb-6">
                            <h6 class="mb-0">Select a rating(required)</h6>
                            <div class="star-rating text-yellow-darker ml-3 font-size-4 form-check-inline">
                                <div class="star-rating__wrap">
                                    <input class="star-rating__input" id="star-rating-5" type="radio" name="rating" value="5">
                                    <label class="star-rating__ico far fa-star" for="star-rating-5" title="5 out of 5 stars"></label>
                                    <input class="star-rating__input" id="star-rating-4" type="radio" name="rating" value="4">
                                    <label class="star-rating__ico far fa-star" for="star-rating-4" title="4 out of 5 stars"></label>
                                    <input class="star-rating__input" id="star-rating-3" type="radio" name="rating" value="3">
                                    <label class="star-rating__ico far fa-star" for="star-rating-3" title="3 out of 5 stars"></label>
                                    <input class="star-rating__input" id="star-rating-2" type="radio" name="rating" value="2">
                                    <label class="star-rating__ico far fa-star" for="star-rating-2" title="2 out of 5 stars"></label>
                                    <input class="star-rating__input" id="star-rating-1" type="radio" name="rating" value="1">
                                    <label class="star-rating__ico far fa-star" for="star-rating-1" title="1 out of 5 stars"></label>
                                </div>
                            </div>
                        </div>
                        <div class="js-form-message form-group mb-4">
                            <label for="descriptionTextarea" class="form-label text-dark h6 mb-3">Details please! Your review helps other shoppers.</label>
                            <textarea class="form-control rounded-0 p-4" rows="7" id="descriptionTextarea"
                                      placeholder="What did you like or dislike? What should other shoppers know before buying?"
                                      required="" data-msg="Please enter your message." data-error-class="u-has-error"
                                      data-success-class="u-has-success" name="comment"></textarea>
                        </div>
                        <div class="form-group mb-5">
                            <label for="inputCompanyName" class="form-label text-dark h6 mb-3">Add a title</label>
                            <input type="text" class="form-control rounded-0 px-4" name="headline" id="inputCompanyName"
                                   placeholder="3000 characters remaining" aria-label="3000 characters remaining">
                        </div>
                        <div class="d-flex">
                            <c:if test="${submitReviewLink == '/submit_review' }">
                                <button type="submit" class="btn btn-dark btn-wide rounded-0 transition-3d-hover">Submit Review</button>
                            </c:if>
                            <c:if test="${submitReviewLink != '/submit_review' }">
                                <a href="${submitReviewLink}">
                                    <button type="button" class="btn btn-dark btn-wide rounded-0 transition-3d-hover">Submit Review</button>
                                </a>
                            </c:if>

                        </div>

                    </form><!--Form submit review-->



                    <!-- End tab write review from user -->
                </div>
            </div>
            <!-- End Tab Content -->
        </div><!--End nav-->
    </div>
</section>
<c:if test="${message != null}">
    <jsp:include page="/frontend/toast.jsp"/>
</c:if>
<%@include file="/components/Footer.jsp"%>

<script src="/assets/js/components/hs.counter.js"></script>
<jsp:include page="/importLib.jsp" />

</body>

</html>