class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
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
  item.destroy
  redirect_to public_items_path
  end
  
end