module ApplicationHelper
  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def invite_button(user)
    if user == current_user
      content_tag(:span, 'Me' , class: "badge badge-info")
    elsif current_user.friend_state(user).blank?
      button_to 'Add Friend', invite_friend_user_path(user), remote: true, class: "btn btn-outline-info mt-3"
    elsif current_user.friend_state(user) == 'accept'
      content_tag(:span, 'Your Friend' , class: "btn btn-info disabled mt-3")
    else
      content_tag(:span, 'Waiting...' , class: "btn btn-outline-info disabled mt-3")
    end
  end
end
