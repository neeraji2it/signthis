$ ->
  $("input[data-sync-textarea]").on 'change', (event) ->
    field = $(@).data('sync-textarea')
    selector = "textarea#document_#{field}"
    $corresponded_textarea = $(selector)
    if $(@).prop('checked')
      $corresponded_textarea.attr('disabled', false)
    else
      $corresponded_textarea.val ""
      $corresponded_textarea.attr('disabled', true)
