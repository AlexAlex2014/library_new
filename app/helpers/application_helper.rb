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

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == params[:sort]) ? "current #{sort_direction}" : nil
    direction = (column == params[:sort] && sort_direction == "asc") ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end
end
