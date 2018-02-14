$(function() {
  // Selectors
  var showFiltersButtonSelector = "#home-toolbar-show-filters";
  var filtersContainerSelector = "#home-toolbar-filters";

  // Elements
  var $showFiltersButton = $(showFiltersButtonSelector);
  var $filtersContainer = $(filtersContainerSelector);

  $showFiltersButton.click(function() {
    $showFiltersButton.toggleClass("selected");
    $filtersContainer.toggleClass("home-toolbar-filters-mobile-hidden");
  });

  // Relocate filters
  if ($("#filters").length && $("#desktop-filters").length) {
    relocate(768, $("#filters"), $("#desktop-filters").get(0));
  }

  //relocate(768, $("#header-menu-mobile-anchor"), $("#header-menu-desktop-anchor").get(0));
  relocate(768, $("#header-user-mobile-anchor"), $("#header-user-desktop-anchor").get(0));
});

$(document).ready(function() {
  $('.filter-grid, .listings-row').on('click', '.add-to-favorites', function(event) {
    var $icon = $(this).find('.icon-part');
    var iconAdded = "icon-heart";
    var iconDeleted = "icon-heart-empty";
    var url = $(this).data('href');

    $.ajax({
      url: url,
      type: "PUT"
    }).done(function(data, status) {
      if (data['status'] === 'deleted') {
        $icon.removeClass(iconAdded);
        $icon.addClass(iconDeleted);
      }
      else if (data['status'] === 'added') {
        $icon.removeClass(iconDeleted);
        $icon.addClass(iconAdded);
      }
    }).fail(function() {});

    event.preventDefault();
    event.stopPropagation();
  });
});
