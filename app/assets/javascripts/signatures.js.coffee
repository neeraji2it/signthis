$ ->
  $(".time").text (index, text) ->
    utc = $(@).data().utc
    time = new Date(parseInt(utc))
    moment(time).format('MMMM Do YYYY, HH:mm:ss') if utc

  $("body").on 'click', '.signature-clear', (event) ->
    $input = $(@).parents('form').find('.signature_input')[0]
    $input.value = ''
    return false
