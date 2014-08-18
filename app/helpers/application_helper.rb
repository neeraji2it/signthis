module ApplicationHelper
  def print_button(text)
    link_to text, '#', onclick: 'window.print();return false;', class: 'button'
  end

  def all_users_except_current
    User.all - [current_user]
  end

  def form_clear_button
    link_to 'Clear', '#', id: 'clear_form', class: 'button'
  end

  def wevorce_logo
    image_tag image_path "wevorce-full-logo.png"
  end
end
