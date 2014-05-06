$ ->
  return if typeof Stripe == "undefined"
  Stripe.setPublishableKey($("meta[name='stripe-key']").attr("content"))
  $(document).on "submit", "#new_order", ->
    $("input[type=submit]").attr("disabled", true)
    if $("#order_card_number").length
      processCard()
      false

processCard = ->
  card =
    number: $("#order_card_number").val()
    cvc: $("#order_cvc").val()
    expMonth: $("#order_card_month_2i").val()
    expYear: $("#order_card_year_1i").val()
  Stripe.createToken(card, handleStripeResponse)

handleStripeResponse= (status, response)->
  if status == 200
    $("#order_card_number").val("")
    $("#order_cvc").val("")
    $("#order_card_month_2i").val("")
    $("#order_card_year_1i").val("")
    $("#order_stripe_card_token").val(response.id)
    $("#new_order")[0].submit()
  else
    $("#stripe-error").text(response.error.message)
    $("input[type=submit]").attr("disabled", false)