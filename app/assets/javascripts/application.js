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
//= require rails-ujs
//= require activestorage
//= require jquery
//= require turbolinks
//= require_tree .

$(document).ready(function () {
    enableBlockUI();
    upgradeDomOnTurboLinksLoad();
});

function enableBlockUI() {
    $.blockUI.defaults.message = '<h4>Please wait...</h4>';
    $.blockUI.defaults.css.border = 'none';
    $.blockUI.defaults.css.opacity = '.8';
    $.blockUI.defaults.baseZ = '10000';

    // enable on all ajax calls
    $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);

    // enable on all form submissions
    $("form").submit(function() {
        $.blockUI();
    });
}

function upgradeDomOnTurboLinksLoad() {
    document.addEventListener('turbolinks:load', function() {
        componentHandler.upgradeDom();
    });
}
