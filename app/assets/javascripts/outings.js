var columns = {
    expand_collapse: {
        index: 0
    },
    rank: {
        index: 1
    }
};

var selectors = {
    btn_expand_all: "button.expand-all",
    btn_expansion: "a.expansion-button",
    icon_collapse: "fa-angle-down",
    icon: "i.fas",
    icon_expand: "fa-angle-right"
};

$(document).on('turbolinks:load', function() {
    setupTables();
    setupExpandAllBtn();
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

function setupExpandAllBtn() {
    $(selectors.btn_expand_all).click(function () {
        var btnText = $(this)[0].innerText.indexOf('EXPAND') > -1 ? "COLLAPSE ALL" : "EXPAND ALL";
        setExpandCollapseIcon($(this).find(selectors.icon)[0]);
        $(this)[0].innerHTML = $(this).find(selectors.icon)[0].outerHTML + btnText;

        var tabId = $(this).closest('div.tab-pane')[0].id;
        var outingDate = tabId.substring(tabId.indexOf("tab-for-") + "tab-for-".length, tabId.length);

        $(selectors.btn_expand_all).closest('div.row').next('table').find('tr.team-row').each(function () {
            // find all anchors whose href ends with the outingDate, and click them to expand / collapse
            $(this).find('[href$=' + outingDate + ']').click();
        });
    });
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
