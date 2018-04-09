document.addEventListener('turbolinks:load', function(){
  $('#modal-window').on('show.bs.modal', function(e) {
    $('#transaction_cross_categories_transactions_attributes_category_to_id').on('change', function() {
      var self = this;
      $('#transaction_cross_categories_transactions_attributes_category_from_id').find('option').prop('disabled', function() {
        return this.value == self.value
      });
    });

    $('#transaction_cross_categories_transactions_attributes_category_from_id').on('change', function() {
      var self = this;
      $('#transaction_cross_categories_transactions_attributes_category_to_id').find('option').prop('disabled', function() {
        return this.value == self.value
      });
    });
  });
});
