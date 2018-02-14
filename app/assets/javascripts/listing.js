window.ST = window.ST || {};

(function(module) {
  module.listing = function() {
    $('#add-to-updates-email').on('click', function() {
      var text = $(this).find('#add-to-updates-email-text');
      var actionLoading = text.data('action-loading');
      var actionSuccess = text.data('action-success');
      var actionError = text.data('action-error');
      var url = $(this).attr('href');

      text.html(actionLoading);

      $.ajax({
        url: url,
        type: "PUT",
      }).done(function() {
        text.html(actionSuccess);
      }).fail(function() {
        text.html(actionError);
      });
    });

    $('#add-to-favorites').on('click', function(event) {
      var $text = $(this).find('#favor-text');
      var actionLoading = $text.data('action-loading');
      var actionSuccessAdded = $text.data('action-success-added');
      var actionSuccessDeleted = $text.data('action-success-deleted');
      var actionError = $text.data('action-error');
      var url = $(this).data('href');

      var $icon = $(this).find('i.icon-part');
      var iconAdded = "icon-heart";
      var iconDeleted = "icon-heart-empty";
      $text.html(actionLoading);

      $.ajax({
        url: url,
        type: "PUT"
      }).done(function(data, status) {
        if (data['status'] === 'deleted') {
          $text.html(actionSuccessDeleted);
          $icon.removeClass(iconAdded);
          $icon.addClass(iconDeleted);
        }
        else if (data['status'] === 'added') {
          $text.html(actionSuccessAdded);
          $icon.removeClass(iconDeleted);
          $icon.addClass(iconAdded);
        }
      }).fail(function() {
        $text.html(actionError);
      });

      event.preventDefault();
      event.stopPropagation();
    });
  };

  module.initializeQuantityValidation = function(opts) {
    jQuery.validator.addMethod(
      "positiveIntegers",
      function(value) {
        return (value % 1) === 0 && value > 0;
      },
      jQuery.validator.format(opts.errorMessage)
    );

    // add rule to input
    $('#'+opts.input).rules("add", {
      positiveIntegers: true
    });
  };

  module.initializeShippingPriceTotal = function(currencyOpts, quantityInputSelector, shippingPriceSelector){
    var $quantityInput = $(quantityInputSelector);
    var $shippingPriceElements = $(shippingPriceSelector);

    var updateShippingPrice = function() {
      $shippingPriceElements.each(function(index, shippingPriceElement) {
        var $priceEl = $(shippingPriceElement);
        var shippingPriceCents = $priceEl.data('shipping-price') || 0;
        var perAdditionalCents = $priceEl.data('per-additional') || 0;
        var quantity = parseInt($quantityInput.val() || 0);
        var additionalCount = Math.max(0, quantity - 1);

        // To avoid floating point issues, do calculations in cents
        var newShippingPrice = shippingPriceCents + perAdditionalCents * additionalCount;
        var priceForDisplay = ST.paymentMath.displayMoney(newShippingPrice,
                                                          currencyOpts.symbol,
                                                          currencyOpts.digits,
                                                          currencyOpts.format,
                                                          currencyOpts.separator,
                                                          currencyOpts.delimiter)
        $priceEl.text(priceForDisplay);
      });
    };

    $quantityInput.on("keyup change", updateShippingPrice); // change for up and down arrows
    updateShippingPrice();
  };

})(window.ST);
