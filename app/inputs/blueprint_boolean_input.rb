class BlueprintBooleanInput < SimpleForm::Inputs::BooleanInput
  def input
    build_hidden_field_for_checkbox +
    build_check_box_without_hidden_field +
    label
  end

  def label_input
    options[:label] = false
    input
  end

  def label
    @builder.label(label_target) { "" }
  end
end
