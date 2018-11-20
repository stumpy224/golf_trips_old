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
        "preventDuplicates": false,
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
    toastr.error(message,
        {
            "closeButton": true,
            "timeOut": 0,
            "extendedTimeOut": 0
        }
    );
}

function notifyOfInfo(message) {
    setupDefaultOptions();
    toastr.info(message,
        {
            "closeButton": true,
            "timeOut": 0,
            "extendedTimeOut": 0
        }
    );
}

function notifyOfSuccess(message) {
    setupDefaultOptions();
    toastr.success(message,
        {
            "closeButton": false,
            "timeOut": 5000,
            "extendedTimeOut": 1000
        }
    );
}

function notifyOfWarning(message) {
    setupDefaultOptions();
    toastr.warning(message,
        {
            "closeButton": true,
            "timeOut": 0,
            "extendedTimeOut": 0
        }
    );
}
