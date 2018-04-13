document.addEventListener('turbolinks:load', function(){
  $('#modal-window').on('show.bs.modal', function(e) {
    var toSelector = $('#transaction_cross_categories_transactions_attributes_category_to_id')
    var fromSelector = $('#transaction_cross_categories_transactions_attributes_category_from_id')

    toSelector.on('change', function() {
      var toValue = this.value;

      fromSelector.find('option').prop('disabled', function() {
        return this.value == toValue;
      });
    });

    fromSelector.on('change', function() {
      var fromValue = this.value;

      toSelector.find('option').prop('disabled', function() {
        return this.value == fromValue;
      });
    });
  });
});
