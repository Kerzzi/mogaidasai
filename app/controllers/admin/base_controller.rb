class Admin::BaseController < ActionController::Base

  layout 'admin/layouts/admin'
  before_action :authenticate_user!
  before_action :admin_required
  before_action :fetch_home_data #这样写会增加数据查询量，后续更新

  def admin_required
    if !current_user.admin?
      redirect_to "/", alert: "You are not admin."
    end
  end

  def fetch_home_data
    @categories = Category.grouped_data
  end

end
