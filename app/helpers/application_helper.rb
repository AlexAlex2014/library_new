module ApplicationHelper
  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def button_back_helper(path)
    button_helper(path, "back", "chevron-left")
  end

  def button_new_helper(path, label = nil)
    button_helper(path, label || "new", "plus", "contesto")
  end

  def button_edit_helper(path)
    button_helper(path, "edit", "pencil", "info")
  end

  def button_helper(path, label, icon="home", color="default", id="", method=nil, remote=false)
    render partial: "layouts/partials/button", locals: { target: :button_action, path: path, label: label, icon: icon, color: color, id: id, method: method, remote: remote }
  end
end
