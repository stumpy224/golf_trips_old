var columns = {
    expand_collapse: {
        index: 0
    },
    rank: {
        index: 1
    }
};

var selectors = {
    btn_show_hide_golfers: "button.show-hide-golfers",
    btn_expansion: "a.expansion-button",
    icon: "i.fas",
    icon_collapse: "fa-angle-down",
    icon_expand: "fa-angle-right",
    icon_plus: "fa-plus",
    icon_minus: "fa-minus"
};

$(document).on('turbolinks:load', function() {
    setupTables();
    setupShowHideGolfersBtn();
    setupExpansionGolferTables();
});

function setupTables() {
    $('#golfersTable').DataTable({
        destroy: true,
        info: false,
        paging: false,
        search: true,
        dom: "<'row' <'col-12 d-flex justify-content-center'f>>" +
            "<'row' <'col-12 d-flex justify-content-center't>>"
    });

    $("table.outing-day").DataTable({
        destroy: true,
        paging: false,
        dom: "<'row' <'col-12 d-flex justify-content-center't>>",
        order: [columns.rank.index, 'asc'],
        columnDefs: [{
            targets: columns.expand_collapse.index,
            orderable: false
        }]
    });

    $('#overallTable').DataTable({
        destroy: true,
        lengthMenu: [[-1, 10, 25, 50], ["All", 10, 25, 50]]
    });
}

function setupShowHideGolfersBtn() {
    $(selectors.btn_show_hide_golfers).click(function () {
        var isShowGolfers = $(this)[0].innerText.indexOf('SHOW') > -1;
        var btnText = isShowGolfers ? "HIDE GOLFERS" : "SHOW GOLFERS";
        $(this)[0].innerHTML = btnText;

        var tabId = $(this).closest('div.tab-pane')[0].id;
        var outingDate = tabId.substring(tabId.indexOf("tab-for-") + "tab-for-".length, tabId.length);

        toggleTeamExpansionButtons(isShowGolfers, outingDate);
    });

    function toggleTeamExpansionButtons(isShowGolfers, outingDate) {
        $(selectors.btn_show_hide_golfers).closest('div.row').next('table').find('tr.team-row').each(function () {
            // find all anchors whose href ends with the outingDate, and click them to expand / collapse
            $(this).find('a.expansion-button[href$=' + outingDate + '][aria-expanded=' + !isShowGolfers + ']').click();
        });
    }
}

function setupExpansionGolferTables() {
    $(selectors.btn_expansion).click(function () {
        var expansionElement = $(this).find(selectors.icon)[0];
        setExpandCollapseIcon(expansionElement);
    });

    $("a.dropdown-item[href^='#tab-for-']").click(function () {
        // collapse all golfer and golfers' scores tables
        $("tr.golfer-table-collapse").removeClass("show");
        $("tr.golfer-scores-table-collapse").removeClass("show");

        // reset the expand/collapse icons
        $(selectors.btn_expansion).each(function () {
            var expansionElement = $(this).find(selectors.icon)[0];
            $(expansionElement).addClass(selectors.icon_expand).removeClass(selectors.icon_collapse);
        });
    })
}

function setExpandCollapseIcon(expansionElement) {
    if ($(expansionElement).hasClass(selectors.icon_expand))
        $(expansionElement).removeClass(selectors.icon_expand).addClass(selectors.icon_collapse);
    else
        $(expansionElement).addClass(selectors.icon_expand).removeClass(selectors.icon_collapse);
}
