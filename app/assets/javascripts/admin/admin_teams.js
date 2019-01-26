//= require jquery

let admin_team_selectors = {
    generateTeamsShowDialogBtn: "#generate_teams_show_dialog_btn",
    closeDialogBtn: "button.close-dialog",
    generateTeamsBtn: "#generate_teams_btn",
    outingSelect: "#outing_select",
    outingDatesDiv: "#outing_dates_div",
    outingDatesSelect: "#outing_dates_select",
    generateTeamsButton: "#generate_teams_button"
};

$(document).ready(function () {
    let dialog = document.querySelector('dialog');

    if (dialog != undefined) {
        setupDialog(dialog);
        setupGenerateTeamsButtonClick();
    }
});

function setupDialog(dialog) {
    let showDialogButton = $(admin_team_selectors.generateTeamsShowDialogBtn);
    let closeDialogButton = $(admin_team_selectors.closeDialogBtn);

    if (!dialog.showModal) {
        dialogPolyfill.registerDialog(dialog);
    }

    $(showDialogButton).click(function () {
        dialog.showModal();
        setupGenerateTeamsButtonClick();
        setupOutingOnChangeEvent();
    });

    $(closeDialogButton).click(function () {
        dialog.close();
    });
}

function setupGenerateTeamsButtonClick() {
    $(admin_team_selectors.generateTeamsBtn).click(function () {
        $(admin_team_selectors.generateTeamsBtn).prop('disabled', true);
        $.get({
            url: "/admin/outings/" + $(admin_team_selectors.outingSelect).val() + "/teams/" + $(admin_team_selectors.outingDatesSelect).val() + "/generate",
            success: function () {
                dialog.close();
                window.location.reload();
            }
        });
    });
}

function setupOutingOnChangeEvent() {
    $(admin_team_selectors.outingSelect).change(function () {
        if ($(admin_team_selectors.outingSelect).val() > 0) {
            $.get({
                url: "/admin/outings/" + $(admin_team_selectors.outingSelect).val() + "/get_dates",
                dataType: "json",
                success: function (outingDates) {
                    $(admin_team_selectors.outingDatesSelect).empty().append($("<option></option>"));

                    $.each(outingDates, function (index, outingDate) {
                        $(admin_team_selectors.outingDatesSelect)
                            .append($("<option></option>")
                                .attr("value", outingDate)
                                .text(moment(outingDate).format("ddd MMM DD, YYYY")))
                    });
                }
            });

            $(admin_team_selectors.outingDatesDiv).show();
        } else {
            $(admin_team_selectors.outingDatesDiv).hide();
        }
    });
}
