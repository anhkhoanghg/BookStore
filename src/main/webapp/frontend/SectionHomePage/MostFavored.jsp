<!-- Render book rating as width value of style in element with class="star-inner" style="width: 50%" -->
<div class="container">
    <section class="most-favored">
        <h3 class="title">Most Favored Books:</h3>
        <ul id="most-favored" class="cs-hidden wrapper">
            <c:forEach items="${listMostFavoredBooks}" var="book">
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
                            <div class="star-outer">
                                <div class="star-inner"
                                     style="width: <fmt:formatNumber value="${(book.averageRating * 100) / 5}" maxFractionDigits="0" />%">
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </section>
</div>