//= require jquery

var selectors = {
    generateTeamsDialogButton: "#generate_teams_dialog_button",
    outingSelect: "#outing_select",
    outingDatesDiv: "#outing_dates_div",
    outingDatesSelect: "#outing_dates_select",
    generateTeamsButton: "#generate_teams_button"
};

$(document).ready(function () {
    setupDialog();
    setupOutingOnChangeEvent();
});

function setupDialog() {
    var dialog = document.querySelector('dialog');
    var showDialogButton = document.querySelector(selectors.generateTeamsDialogButton);
    if (!dialog.showModal) {
        dialogPolyfill.registerDialog(dialog);
    }
    showDialogButton.addEventListener('click', function () {
        dialog.showModal();
    });
    dialog.querySelector('.close').addEventListener('click', function () {
        dialog.close();
    });
    $(selectors.generateTeamsButton).click(function () {
        $(selectors.generateTeamsButton).prop('disabled', true);
        $.get({
            url: "/admin/outings/" + $(selectors.outingSelect).val() + "/teams/" + $(selectors.outingDatesSelect).val() + "/generate",
            success: function () {
                dialog.close();
                window.location.reload();
            }
        });
    });
}

function setupOutingOnChangeEvent() {
    $(selectors.outingSelect).change(function () {
        if ($(selectors.outingSelect).val() > 0) {
            $.get({
                url: "/admin/outings/" + $(selectors.outingSelect).val() + "/get_dates",
                dataType: "json",
                success: function (outingDates) {
                    $(selectors.outingDatesSelect).empty().append($("<option></option>"));

                    $.each(outingDates, function (index, outingDate) {
                        $(selectors.outingDatesSelect)
                            .append($("<option></option>")
                                .attr("value", outingDate)
                                .text(moment(outingDate).format("ddd MMM DD, YYYY")))
                    });
                }
            });

            $(selectors.outingDatesDiv).show();
        } else {
            $(selectors.outingDatesDiv).hide();
        }
    });
}
