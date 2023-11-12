<c:forTokens items="${book.ratingStars}" delims="," var="star">
    <c:if test="${star eq 'on'}">
        <small class="fas fa-star"></small>
    </c:if>
    <c:if test="${star eq 'half'}">
        <small class="fas fa-star-half"></small>
    </c:if>
</c:forTokens>