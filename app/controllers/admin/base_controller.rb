class Admin::BaseController < ActionController::Base

  layout 'admin/layouts/admin'
  before_action :authenticate_user!
  before_action :admin_required

  def admin_required
   if !current_user.admin?
     redirect_to "/", alert: "You are not admin."
   end
  end
end
