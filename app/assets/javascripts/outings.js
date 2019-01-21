var columns = {
    expand_collapse: {
        index: 0
    },
    rank: {
        index: 1
    }
};

var selectors = {
    nav_link: "a.nav-link",
    nav_dropdown: "a.dropdown-item",
    btn_show_hide_golfers: "button.show-hide-golfers",
    btn_expansion: "a.expansion-button",
    icon: "i.fas",
    icon_collapse: "fa-angle-down",
    icon_expand: "fa-angle-right",
    icon_plus: "fa-plus",
    icon_minus: "fa-minus"
};

$(document).on('turbolinks:load', function () {
    handleNavClicks();
    setupTables();
    setupShowHideGolfersBtn();
    setupExpansionGolferTables();
});

function handleNavClicks() {
    $(selectors.nav_link).click(function () {
        if (!$(this).hasClass('dropdown-toggle')) {
            scrollToTop();
        }
    });

    $(selectors.nav_dropdown).click(function () {
        scrollToTop();
    });
}

function scrollToTop() {
    $("html, body").animate({scrollTop: 0}, "slow");
    return false;
}

function setupTables() {
    $("#golfersTable").DataTable({
        destroy: true,
        info: false,
        paging: false,
        search: true,
        dom: "<'row' <'col-12 d-flex justify-content-center'f>>" +
            "<'row' <'col-12 d-flex justify-content-center't>>"
    });

    $("#overallTable").DataTable({
        destroy: true,
        lengthMenu: [[-1, 10, 25, 50], ["All", 10, 25, 50]]
    });

    $("table.outing-day-table tbody").on("click", "tr.team-row", function () {
        $(this).find(selectors.btn_expansion)[0].click();
    });

    $("table.golfers-by-team-table tbody").on("click", "tr.golfer-row", function () {
        $(this).find(selectors.btn_expansion)[0].click();
    });
}

function setupShowHideGolfersBtn() {
    $(selectors.btn_show_hide_golfers).click(function () {
        // update button icon
        setPlusMinusIcon($(this).find(selectors.icon)[0]);

        var isShowGolfers = $(this)[0].innerText.indexOf('SHOW') > -1;
        var btnText = isShowGolfers ? "HIDE GOLFERS" : "SHOW GOLFERS";
        $(this)[0].innerHTML = $(this).find(selectors.icon)[0].outerHTML + btnText;

        var tabId = $(this).closest('div.tab-pane')[0].id;
        var outingDate = tabId.substring(tabId.indexOf("tab-for-") + "tab-for-".length, tabId.length);

        toggleTeamExpansionButtons(isShowGolfers, outingDate);
    });
}


function setupExpansionGolferTables() {
    $(selectors.btn_expansion).click(function () {
        setExpandCollapseIcon($(this).find(selectors.icon)[0]);
    });

    $(selectors.nav_dropdown + "[href^='#tab-for-']").click(function () {
        resetExpansionButtonsAndLinks();
    });

    $(selectors.nav_link + "[href^='#tab-for-']").click(function () {
        resetExpansionButtonsAndLinks();
    });
}

function setPlusMinusIcon(expansionElement) {
    setIcon(expansionElement, selectors.icon_plus, selectors.icon_minus);
}

function setExpandCollapseIcon(expansionElement) {
    setIcon(expansionElement, selectors.icon_expand, selectors.icon_collapse);
}

function setIcon(expansionElement, expandIconSelector, collapseIconSelector) {
    if ($(expansionElement).hasClass(expandIconSelector))
        $(expansionElement).removeClass(expandIconSelector).addClass(collapseIconSelector);
    else
        $(expansionElement).addClass(expandIconSelector).removeClass(collapseIconSelector);
}

function resetExpansionButtonsAndLinks() {
    // collapse all golfer and golfers' scores tables
    $("tr.golfer-table-collapse").removeClass("show");
    $("tr.golfer-scores-table-collapse").removeClass("show");

    // reset each Show / Hide Golfers button that has been expanded
    $(selectors.btn_show_hide_golfers).each(function () {
        if ($(this).find(selectors.icon).hasClass(selectors.icon_minus)) {
            $(this).click();
        }
    });

    // reset each expand / collapse icons
    $(selectors.btn_expansion).each(function () {
        var expansionElement = $(this).find(selectors.icon)[0];
        $(expansionElement).addClass(selectors.icon_expand).removeClass(selectors.icon_collapse);
        $(this).attr("aria-expanded", "false");
    });
}

function toggleTeamExpansionButtons(isShowGolfers, outingDate) {
    $(selectors.btn_show_hide_golfers).closest("div.row").next("table").find("tr.team-row").each(function () {
        // find all anchors whose href ends with the outingDate, and click them to expand / collapse
        var teamExpansionButton = $(this).find(selectors.btn_expansion + '[href$=' + outingDate + '][aria-expanded=' + !isShowGolfers + ']');
        $(teamExpansionButton).click();
        setExpandCollapseIcon($(teamExpansionButton).find(selectors.icon)[0]);
    });
}
