#= require jquery
#= require jquery_ujs
#= require jquery-ui
#= require jquery.ui.touch-punch
#= require jquery.signature
#= require moment
#= require turbolinks

#= require signatures
#= require blueprint
#= require purchase

$ ->
  $("body").on 'click', '.dismiss', -> $(@).parent().hide()

  $("#clear_form").on 'click', ->
    $form = $(@).closest('form')
    $form.find("input[type=text], input[type=email], textarea").val("")
    $form.find("input[type=checkbox]").removeAttr('checked')
    $form.find(".detours textarea").attr('disabled', true)
    false

  $("#document_email_button").on 'click', ->
    formData = $("form").serialize()
    $(@).data('params', formData)
    true
