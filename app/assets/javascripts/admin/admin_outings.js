//= require jquery

var selectors = {
    outingStartDate: "#outing_start_date",
    outingEndDate: "#outing_end_date",
};

$(document).ready(function () {
    $(selectors.outingStartDate).change(function () {
        var startDateValue = $(this).val();

        if (startDateValue && $(selectors.outingEndDate).val() == "") {
            $(selectors.outingEndDate).val(startDateValue);
        }
    });
});
