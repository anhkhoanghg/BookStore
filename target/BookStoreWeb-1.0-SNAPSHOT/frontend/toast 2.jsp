<div id="toast-custom">
    <div class="toast-custom toast-custom-show toast-custom-${message.status}">
        <div class="toast-icon text-custom-${message.status}">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor"
                 class="bi bi-check-circle-fill" viewBox="0 0 16 20">
                <path
                        d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z" />
            </svg>
        </div>
        <div class="toast-body-custom">
            <h3 class="toast-title">${message.title}</h3>
            <p class="toast-message font-italic">${message.msg}</p>
        </div>
        <div class="toast-close-custom text-secondary" id="toast-close" >
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-x-lg"
                 viewBox="0 0 16 20">
                <path fill-rule="evenodd"
                      d="M13.854 2.146a.5.5 0 0 1 0 .708l-11 11a.5.5 0 0 1-.708-.708l11-11a.5.5 0 0 1 .708 0Z" />
                <path fill-rule="evenodd"
                      d="M2.146 2.146a.5.5 0 0 0 0 .708l11 11a.5.5 0 0 0 .708-.708l-11-11a.5.5 0 0 0-.708 0Z" />
            </svg>
        </div>
    </div>
</div>
<script type="text/javascript">
    setTimeout(function () {
        $('#toast-close').click(function () {
            $(".toast-custom").removeClass("toast-custom-show");
        });
    }, 1000);
    setTimeout(function () { $('.toast-close-custom').click(); }, 3000);
</script>