<div class="container">
  <section class="best-selling">
    <h3 class="title">Best Selling:</h3>
    <ul id="best-selling" class="cs-hidden wrapper">
      <c:forEach items="${listBestSellingBooks}" var="book">
        <li class="item">
          <div class="box">
            <div class="slide-img">
              <img src="data:image/jpg;base64,${book.base64Image}" alt="${book.title}">
              <div class="overlay">
                <a href="/add_to_cart?book_id=${book.bookId}" class="btn-buy text-dark">Buy Now</a>
              </div>
            </div>
            <div class="detail-box">
              <div class="title">
                <p class="text-dark text-truncate">${book.title}</p>
              </div>
              <span class="price text-muted"><fmt:formatNumber value="${book.price}" type="currency"/></span>
            </div>
          </div>
        </li>
      </c:forEach>
    </ul>
  </section>
</div>