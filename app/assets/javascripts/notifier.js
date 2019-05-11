$(document).ready(function(){
    setupDefaultOptions();
});

function setupDefaultOptions() {
    toastr.options = {
        "closeButton": false,
        "debug": false,
        "newestOnTop": false,
        "progressBar": false,
        "positionClass": "toast-top-center",
        "preventDuplicates": true,
        "onclick": null,
        "showDuration": "300",
        "hideDuration": "1000",
        "timeOut": "5000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    };
}

function notifyOfError(message) {
    setupDefaultOptions();
    toastr.options.closeButton = true;
    toastr.options.timeOut = 5000;
    toastr.options.extendedTimeOut = 0;
    toastr.error(message[0].innerText);
}

function notifyOfInfo(message) {
    setupDefaultOptions();
    toastr.options.closeButton = true;
    toastr.options.timeOut = 5000;
    toastr.options.extendedTimeOut = 0;
    toastr.info(message[0].innerText);
}

function notifyOfSuccess(message) {
    setupDefaultOptions();
    toastr.options.closeButton = false;
    toastr.options.timeOut = 3000;
    toastr.success(message[0].innerText);
}

function notifyOfWarning(message) {
    setupDefaultOptions();
    toastr.options.closeButton = true;
    toastr.options.timeOut = 3000;
    toastr.options.extendedTimeOut = 0;
    toastr.warning(message[0].innerText);
}
