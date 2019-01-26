//= require jquery

let admin_outing_selectors = {
    outingStartDate: "#outing_start_date",
    outingEndDate: "#outing_end_date",
};

$(document).ready(function () {
    $(admin_outing_selectors.outingStartDate).change(function () {
        let startDateValue = $(this).val();

        if (startDateValue && $(admin_outing_selectors.outingEndDate).val() == "") {
            $(admin_outing_selectors.outingEndDate).val(startDateValue);
        }
    });
});
