module ApplicationHelper
  def admin?
    redirect_to root_url unless current_user.admin?
  end
end
