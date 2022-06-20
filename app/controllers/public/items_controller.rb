class Public::ItemsController < ApplicationController

  def new
      @item = Item.new(params[:id])
  end
  
  def create
    @item = Item.new(item_params)
    @item.customer_id = current_customer.id
    #tag_list=params[:item][:name].split(',')
    if @item.save
    #@item.save_tag(tag_list)
    flash[:notice] = "You have created item successfully."
    redirect_to public_item_path(@item.id)
    else
    @customer = current_customer
    @items = item.all
    render :new
    end
  end
  
  def index
    @customer = current_customer
    @items = Item.all
    @quantity = Item.count
    @tag_list = Tag.all
  end
  
  def show
    @item = Item.find(params[:id])
    @customer = @item.customer
    @comment = Comment.new
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
    flash[:notice] = "You have updated item successfully."
    redirect_to public_item_path(@item.id)
    else
    render :edit
    end
  end
  
  def destroy
    @item = Item.find(params[:id])
    item.destroy
    redirect_to public_items_path
  end
  
  private
  
  def item_params
    params.require(:item).permit(:body, :itemname, :price, :product_image, :evaluation)
  end
end