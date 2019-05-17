let outing_selectors = {
    outing_header: "#outingHeader",
    nav_link: "a.nav-link",
    nav_dropdown: "a.dropdown-item",
    btn_show_hide_golfers: "button.show-hide-golfers",
    btn_expansion: "a.expansion-button",
    icon: "i.fas",
    icon_collapse: "fa-angle-down",
    icon_expand: "fa-angle-right",
    icon_plus: "fa-plus",
    icon_minus: "fa-minus",
    scroll_to_top_btn: "#scrollToTopBtn",
    sticky: ".sticky"
};

$(document).on('turbolinks:load', function () {
    handleHashTagsInUrl();
    handleNavClicks();
    handleScrollToTop();
    setupTables();
    setupShowHideGolfersBtn();
    setupExpansionGolferTables();
    stickyOutingHeader();
});

function handleHashTagsInUrl() {
    let url = window.location.href;

    if (url.indexOf("#tab-for")) {
        let hashFromUrl = url.substring(url.indexOf("#tab-for"), url.length);
        let hrefSelector = "[href='" + hashFromUrl + "']";

        if ($(outing_selectors.nav_dropdown + hrefSelector)) {
            $(outing_selectors.nav_dropdown + hrefSelector).click();
            scrollToTop();
        } else if ($(outing_selectors.nav_link + hrefSelector)) {
            $(outing_selectors.nav_link + hrefSelector).click();
            scrollToTop();
        }
    }
}

function handleNavClicks() {
    $(outing_selectors.nav_link).click(function () {
        if (!$(this).hasClass('dropdown-toggle')) {
            scrollToTop();
        }
    });

    $(outing_selectors.nav_dropdown).click(function () {
        scrollToTop();
    });
}

function handleScrollToTop() {
    $(window).scroll(function () {
        $(window).scrollTop() >= 75 ?
            $(outing_selectors.scroll_to_top_btn).show() : $(outing_selectors.scroll_to_top_btn).hide();
    });
}

function setupTables() {
    let outingName = $.trim($(outing_selectors.outing_header).text());

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
        paging: false,
        // lengthMenu: [[-1, 10, 25, 50], ["All", 10, 25, 50]],
        dom: 'Bfti',
        buttons: [
            {
                extend: 'print',
                text: 'Print',
                title: outingName + ' Overall Stats'
            },
            {
                extend: 'excelHtml5',
                text: 'Excel',
                title: outingName + ' Overall Stats'
            },
            {
                extend: 'pdfHtml5',
                text: 'PDF',
                title: outingName + ' Overall Stats'
            }
        ]
    });

    $("#docsTable").DataTable({
        destroy: true,
        info: false,
        paging: false,
        dom: "<'row' <'col-12 d-flex justify-content-center't>>",
        order: [[1, "asc"]],
        columnDefs: [{
            targets: 0,
            orderable: false
        }]
    });

    $("table.outing-day-table tbody tr.team-row").on("click", function () {
        $(this).find(outing_selectors.btn_expansion)[0].click();
    });

    $("table.golfers-by-team-table tbody tr.golfer-row").on("click", function () {
        $(this).find(outing_selectors.btn_expansion)[0].click();
    });
}

function setupShowHideGolfersBtn() {
    $(outing_selectors.btn_show_hide_golfers).click(function () {
        // update button icon
        setPlusMinusIcon($(this).find(outing_selectors.icon)[0]);

        let isShowGolfers = $(this)[0].innerText.indexOf('SHOW') > -1;
        let btnText = isShowGolfers ? "HIDE GOLFERS" : "SHOW GOLFERS";
        $(this)[0].innerHTML = $(this).find(outing_selectors.icon)[0].outerHTML + btnText;

        let tabId = $(this).closest('div.tab-pane')[0].id;
        let outingDate = tabId.substring(tabId.indexOf("tab-for-") + "tab-for-".length, tabId.length);

        toggleTeamExpansionButtons(isShowGolfers, outingDate);
    });
}


function setupExpansionGolferTables() {
    $(outing_selectors.btn_expansion).click(function () {
        setExpandCollapseIcon($(this).find(outing_selectors.icon)[0]);
    });

    $(outing_selectors.nav_dropdown + "[href^='#tab-for-']").click(function () {
        resetExpansionButtonsAndLinks();
    });

    $(outing_selectors.nav_link + "[href^='#tab-for-']").click(function () {
        resetExpansionButtonsAndLinks();
    });
}

function setPlusMinusIcon(expansionElement) {
    setIcon(expansionElement, outing_selectors.icon_plus, outing_selectors.icon_minus);
}

function setExpandCollapseIcon(expansionElement) {
    setIcon(expansionElement, outing_selectors.icon_expand, outing_selectors.icon_collapse);
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
    $(outing_selectors.btn_show_hide_golfers).each(function () {
        if ($(this).find(outing_selectors.icon).hasClass(outing_selectors.icon_minus)) {
            $(this).click();
        }
    });

    // reset each expand / collapse icons
    $(outing_selectors.btn_expansion).each(function () {
        let expansionElement = $(this).find(outing_selectors.icon)[0];
        $(expansionElement).addClass(outing_selectors.icon_expand).removeClass(outing_selectors.icon_collapse);
        $(this).attr("aria-expanded", "false");
    });
}

function toggleTeamExpansionButtons(isShowGolfers, outingDate) {
    $(outing_selectors.btn_show_hide_golfers).closest("div.row").next("table").find("tr.team-row").each(function () {
        // find all anchors whose href ends with the outingDate, and click them to expand / collapse
        let teamExpansionButton = $(this).find(outing_selectors.btn_expansion + '[href$=' + outingDate + '][aria-expanded=' + !isShowGolfers + ']');
        $(teamExpansionButton).click();
        setExpandCollapseIcon($(teamExpansionButton).find(outing_selectors.icon)[0]);
    });
}

function stickyOutingHeader() {
    let stickyOffset = $(outing_selectors.sticky).offset();

    if (stickyOffset) {
        $(window).scroll(function () {
            $(window).scrollTop() >= stickyOffset.top ?
                $(outing_selectors.sticky).addClass('fixed') : $(outing_selectors.sticky).removeClass('fixed');
        });
    }
}
