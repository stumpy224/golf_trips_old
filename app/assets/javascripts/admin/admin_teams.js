//= require jquery
//= require jquery.modal.min

let admin_team_selectors = {
    generateTeamsBtn: "#generate_teams_btn",
    outingSelect: "#outing_select",
    outingDatesDiv: "#outing_dates_div",
    outingDatesSelect: "#outing_dates_select",
    teamGenerationDiv: "#team-generation",
    pleaseWaitDiv: "#please-wait"
};

$(document).ready(function () {
    setupGenerateTeamsButtonClick();
    setupOutingOnChangeEvent();
});

function setupGenerateTeamsButtonClick() {
    $(admin_team_selectors.generateTeamsBtn).click(function () {
        $(admin_team_selectors.generateTeamsBtn).prop('disabled', true);
        $.get({
            url: "/admin/outings/" + $(admin_team_selectors.outingSelect).val() + "/teams/" + $(admin_team_selectors.outingDatesSelect).val() + "/generate",
            success: function () {
                $(admin_team_selectors.teamGenerationDiv).hide();
                $(admin_team_selectors.pleaseWaitDiv).show();
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
