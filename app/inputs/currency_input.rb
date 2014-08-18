class CurrencyInput < SimpleForm::Inputs::Base
  def input
    template.content_tag(:span, "$ ", class: "add-on") +
      @builder.text_field(attribute_name, input_html_options)
  end
end
