$ -> 
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  subscription.setupForm()

subscription =
  setupForm: ->
    $('#new_purchase').submit ->
      $('input[type=submit]').attr('disabled', true)
      $(".error_messages").html ''
      subscription.processCard()
      false
  
  processCard: ->
    card =
      number: $('#purchase_card_number').val()
      cvc: $('#purchase_card_code').val()
      expMonth: $('#purchase_expiration_date_month').val()
      expYear: $('#purchase_expiration_date_year').val()
    Stripe.createToken(card, subscription.handleStripeResponse)
  
  handleStripeResponse: (status, response) ->
    $purchaseMessageBlock = $(".error_messages", '#new_purchase')
    if status == 200
      $("#purchase_stripe_card_token").val(response.id)
      $("#new_purchase")[0].submit()
    else
      $('input[type=submit]').attr('disabled', false)
      $purchaseMessageBlock.html response.error.message
