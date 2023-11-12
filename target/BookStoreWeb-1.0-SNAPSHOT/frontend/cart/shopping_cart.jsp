<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>

  <title>Shopping cart</title>


  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <link rel="shortcut icon" href="/assets/img/icons/books.ico">
  <jsp:include page="/importCss.jsp" />
  <style>
    body {
      position: absolute;
      min-width: 100%;
    }

    td {
      vertical-align: middle !important;
    }

    .cart-info {
      display: flex;
      flex-wrap: wrap;
      align-items: center;
    }

    .cart-info img {
      width: 3.755rem;
      height: 5rem;
      margin-right: 0.625rem;
    }

    .quantity-custom {
      width: 6.4rem;
      position: relative;
      margin: auto;
    }

    .number-custom::-webkit-outer-spin-button,
    .number-custom::-webkit-inner-spin-button {
      -webkit-appearance: none;
    }

    .number-custom {
      width: 2.5rem;
      height: 1.875rem;
      padding: 0 4px;
      text-align: center !important;
      border: 1px solid rgba(0, 0, 0, 0.2);
      border-left: none;
      border-right: none;
    }

    .inc,
    .dec {
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 0.2rem;
      min-width: 1.875rem;
      min-height: 1.875rem;
      width: 1.875rem;
      height: 1.875rem;
      z-index: 1;
      border: 1px solid rgba(0, 0, 0, 0.2);
      background-color: #ffffff;
      cursor: pointer;
      user-select: none;
    }

    .inc:hover,
    .dec:hover {
      background-color: #eae8e4;
    }
  </style>
</head>

<body>

<%@include file="/components/Header.jsp"%>

<div class="container" style="min-height: 360px">
  <div class="table-responsive-lg">
    <c:if test="${cart.totalItems == 0}">
      <h2>There's no item in your cart</h2>
    </c:if>
    <c:if test="${cart.totalItems > 0}">
      <h2>Your cart details</h2>
      <form action="/update_cart" method="post">
        <table class="table table-bordered table-striped table-hover">
          <thead class="thead-dark">
          <tr>
            <th>No.</th>
            <th>Book</th>
            <th>Quantity</th>
            <th>Price</th>
            <th>Subtotal</th>
            <th>Action</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach items="${cart.items}" var="item" varStatus="status">
            <tr>
              <td>${status.index + 1}</td> <!-- / .Product number - auto increase-->
              <td>
                <div class="cart-info">
                  <img src="data:image/jpg;base64,${item.key.base64Image}" alt="Effective Java">
                  <!-- / .Book image-->
                  <p class="m-0 p-2 col-12 text-truncate" style="max-width: 10rem;">${item.key.title}</p>
                  <!-- / .Book name-->
                </div>
              </td>
              <td>
                <div class="quantity-custom d-flex">
                  <div class="dec">
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                         fill="currentColor" class="bi bi-dash-lg" viewBox="0 0 16 16">
                      <path fill-rule="evenodd"
                            d="M2 8a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11A.5.5 0 0 1 2 8Z" />
                    </svg>
                  </div>
                  <input type="hidden" name="bookId" value="${item.key.bookId}"/>
                  <input type="number" name="quantity${status.index + 1}" id="quantity-custom"
                         class="number-custom font-weight-bold" min="1" max="999" value="${item.value}">
                  <!-- / .Change value attribute as your data (quantity)-->
                  <div class="inc">
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                         fill="currentColor" class="bi bi-plus-lg" viewBox="0 0 16 16">
                      <path fill-rule="evenodd"
                            d="M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 0-1h5v-5A.5.5 0 0 1 8 2Z" />
                    </svg>
                  </div>
                </div>
              </td>
              <td>
                <fmt:formatNumber value="${item.key.price * item.value}" type="currency"/>
              </td> <!-- / .Unit price-->
              <td><fmt:formatNumber value="${item.key.price * item.value}" type="currency"/></td> <!-- / .Subtotal price: quantity * unit price-->
              <td>
                <a href="/remove_from_cart?book_id=${item.key.bookId}" class="btn btn-danger btn-sm">Remove</a> <!-- / .Remove selected product-->
              </td>
            </tr>
          </c:forEach>

          </tbody>
          <tfoot>
          <tr>
            <td colspan="2"></td>
            <td class="text-center">${cart.totalQuantity} book(s)</td> <!-- / .Sum of quantities-->
            <td class="text-uppercase"><b>Total:</b></td>
            <td><fmt:formatNumber value="${cart.totalAmount}" type="currency"/></td> <!-- / .Sum of subtotal-->
            <td class="btn btn-danger btn-block text-center">
              <a href="/clear_cart" class="text-light text-decoration-none">Remove All</a>
              <!-- / .Remove all product in cart-->
            </td>
          </tr>
          </tfoot>
        </table>
        <div class="row">
          <div class="btn-toolbar col-12" role="toolbar" aria-label="Toolbar with button groups">
            <div class="btn-group mr-auto ml-auto" role="group" aria-label="First group">
              <button type="submit" class="btn btn-danger btn-block">Update</button>
            </div>
            <div class="btn-group mr-auto" role="group" aria-label="Second group">
              <a href="${pageContext.request.contextPath}/">
                <button type="button" class="btn btn-danger mr-2">Continue Shopping</button>
              </a>
              <a href="${pageContext.request.contextPath}/checkout">
                <button type="button" class="btn btn-outline-danger">Check Out</button>
              </a>
            </div>
          </div>
        </div>
      </form>
    </c:if>
  </div>
</div>

<script>
  $(document).ready(function () {
    $(".dec").each(function () {
      $(this).on("click", function () {
        const decrease = Number($(this).closest(".quantity-custom").find("input").val());
        if (decrease > 1 && decrease <= 999) {
          const decreaseVal = decrease - 1;
          $(this).closest(".quantity-custom").find("input").val(decreaseVal);
        } else if (decrease > 999) {
          $(this).closest(".quantity-custom").find("input").val("999");
        } else {
          $(this).closest(".quantity-custom").find("input").val("1");
        }
      });
    });
    $(".inc").each(function () {
      $(this).on("click", function () {
        const increase = Number($(this).closest(".quantity-custom").find("input").val());
        if (increase >= 1 && increase < 999) {
          const increaseVal = increase + 1;
          $(this).closest(".quantity-custom").find("input").val(increaseVal);
        } else if (increase < 1) {
          $(this).closest(".quantity-custom").find("input").val("1");
        } else {
          $(this).closest(".quantity-custom").find("input").val("999");
        }
      });
    });
  });
</script> <!-- / .Change quantity value-->

<c:if test="${message != null}">
  <jsp:include page="/frontend/toast.jsp"/>
</c:if>

<%@include file="/components/Footer.jsp"%>
<jsp:include page="/importLib.jsp" />

</body>

</html>