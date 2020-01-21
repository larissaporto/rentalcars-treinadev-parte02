class CategoriesController < ApplicationController
  before_action :authorize_admin

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    if @category.persisted?
      redirect_to @category
    else
      flash.now[:alert] = 'Erro, todos os dados devem ser preenchidos'
      render :new
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.update(category_params)
    redirect_to @category
  end
  private

  def category_params
    params.require(:category).permit(:name, :daily_rate, :car_insurance,
                                     :third_party_insurance)
  end
end
