class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authorize_item_owner!, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def authorize_item_owner!
    redirect_to root_path if @item.user != current_user || @item.order.present?
  end

  def item_params
    params.require(:item).permit(
      :image, :name, :description,
      :category_id, :status_id, :shipping_fee_id, :shipping_day_id, :prefecture_id,
      :price
    ).merge(user_id: current_user.id)
  end
end
