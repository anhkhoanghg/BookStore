
<div class="toast show position-fixed text-light ${message.bgColor}" id="toast"
     style="top: 5px; right: 5px; min-width: 280px; z-index: 4;">
    <div class="toast-header ${message.bgColor} text-light">
        <strong class="mr-auto text-light">${message.title}</strong>

        <button type="button" id="toast__button" class="ml-2 mb-1 close text-light"
                data-dismiss="toast" style="background: none; outline: none;">
            x
        </button>
    </div>
    <div class="toast-body">${message.msg}</div>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        $('#toast__button').click(function (){
            document.getElementById('toast').classList.remove('show');
        });
        setTimeout(function(){ $('#toast__button').click(); }, 3000);
    });
</script>