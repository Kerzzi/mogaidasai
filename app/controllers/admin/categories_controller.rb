class Admin::CategoriesController < Admin::BaseController

  before_action :find_root_categories, only: [:new, :create, :edit, :update]
  before_action :find_category, only: [:edit, :update, :destroy]

  def index
    if params[:id].blank?   #如果id为空，则说明没二级分类

      @categories = Category.roots
    else
      @category = Category.find(params[:id])
      @categories = @category.children  #@category.children是ancestry gem自己提供的
    end

    @categories = @categories.page(params[:page] || 1).per_page(params[:per_page] || 10)
      .order(id: "desc")
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params.require(:category).permit!)
    #以哈希类型的属性，必须做一个过滤，防止批量的属性攻击
    #permit!意味着与数据库对应的所有的属性都接收，因为这是后台，所以我这样写
    #但是这不是一种严格的写法

    if @category.save
      flash[:notice] = "保存成功"
      redirect_to admin_categories_path
    else
      render action: :new
    end
  end

  def edit
    render action: :new
  end

  def update
    @category.attributes = params.require(:category).permit!

    if @category.save
      flash[:notice] = "修改成功"
      redirect_to admin_categories_path
    else
      render action: :new
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = "删除成功"
      redirect_to admin_categories_path
    else
      flash[:notice] = "删除失败"
      redirect_to :back
    end
  end

  private
  def find_root_categories
    @root_categories = Category.roots.order(id: "desc")
  end

  def find_category
    @category = Category.find(params[:id])
  end

end
