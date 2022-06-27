class Admin::ItemsController < ApplicationController
  before_action :admin_check
  
  def index
    @items = Item.all.order("id DESC")
    @quantity = Item.count
    @tag_list = Tag.all
  end

  def show
    @item = Item.find(params[:id])
    @customer = @item.customer
    @comment = Comment.new
  end

  def destroy
  @item = Item.find(params[:id])
  @item.destroy
  redirect_to admin_items_path
  end
  
  def tag_search
    @tag_name = Tag.find(params[:tag_id])
    @items = ItemTag.where(tag_id: params[:tag_id])
  end
  
  private

  def item_params
    params.require(:item).permit(:body, :itemname, :price, :product_image, :evaluation)
  end
  
end