module DocumentsHelper
  def document_included_options
    options = []
    Document::OPTIONS_ATTRIBUTES.each do |option|
      options << I18n.t(option, scope: 'activerecord.attributes.document') if @document.send(option)
    end
    options
  end
end
