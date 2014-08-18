class DocumentDecorator < ApplicationDecorator
  delegate_all

  def date
    source.created_at.strftime('%m-%d-%Y') if source.created_at
  end

  def name
    bolded = "bold" unless source.signed?
    h.content_tag :span, filename, class: bolded
  end

  def first_spouse_full_name
    [first_spouse_first_name, first_spouse_last_name].reject(&:nil?).join " "
  end

  def second_spouse_full_name
    [second_spouse_first_name, second_spouse_last_name].reject(&:nil?).join " "
  end

  def link
    h.link_to name, h.document_url(source)
  end

  def billable_hour
    "$#{source.billable_hour}"
  end

  def price
    "$#{source.price}"
  end

  def filename
    [source.first_spouse_last_name, source.second_spouse_last_name, date].reject(&:nil?).join("-")
  end
end
