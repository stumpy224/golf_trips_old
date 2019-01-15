var columns = {
    expand_collapse: {
        index: 0
    },
    rank: {
        index: 1
    }
};

var selectors = {
    collapse_icon: "fa-angle-down",
    expansion_btn: "a.expansion-button",
    expansion_icon: "i.fas",
    expand_icon: "fa-angle-right"
};

$(document).on('turbolinks:load', function() {
    setupTables();
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

function setupExpansionGolferTables() {
    $(selectors.expansion_btn).click(function () {
        var expansionElement = $(this).find(selectors.expansion_icon)[0];

        if ($(expansionElement).hasClass(selectors.expand_icon))
            $(expansionElement).removeClass(selectors.expand_icon).addClass(selectors.collapse_icon);
        else
            $(expansionElement).addClass(selectors.expand_icon).removeClass(selectors.collapse_icon);
    });

    $("a.dropdown-item[href^='#tab-for-']").click(function () {
        // collapse all golfer and golfers' scores tables
        $("tr.golfer-table-collapse").removeClass("show");
        $("tr.golfer-scores-table-collapse").removeClass("show");

        // reset the expand/collapse icons
        $(selectors.expansion_btn).each(function () {
            var expansionElement = $(this).find(selectors.expansion_icon)[0];
            $(expansionElement).addClass(selectors.expand_icon).removeClass(selectors.collapse_icon);
        });
    })
}
