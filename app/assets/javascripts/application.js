// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.blockUI.min
//= require jquery.dataTables.min
//= require jquery.modal.min
//= require popper.min
//= require toastr.min
//= require bootstrap.min
//= require mdb
//= require datatables.min
//= require dataTables.bootstrap4.min
//= require datatables.buttons.min
//= require jszip.min
//= require pdfmake.min
//= require vfs_fonts
//= require buttons.html5.min
//= require buttons.print.min
//= require buttons.bootstrap4.min
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).ready(function () {
    enableBlockUI();
    enableBootstrapDataToggles();
});

function enableBlockUI() {
    $.blockUI.defaults.message = '<h3>Please wait...</h3>';
    $.blockUI.defaults.css.border = 'none';
    $.blockUI.defaults.css.left = '25%';
    $.blockUI.defaults.css.opacity = '.8';
    $.blockUI.defaults.css.padding = '1em';
    $.blockUI.defaults.css.width = '50%';
    $.blockUI.defaults.baseZ = '10000';

    // enable on all ajax calls
    $(document).ajaxStart($.blockUI()).ajaxStop($.unblockUI());

    // enable on all form submissions
    $("form").submit(function () {
        $.blockUI();
    });
}

function enableBootstrapDataToggles() {
    $('[data-toggle="popover"]').popover({
        html: true
    });

    $('[data-toggle="tooltip"]').tooltip({
        html: true
    });
}
