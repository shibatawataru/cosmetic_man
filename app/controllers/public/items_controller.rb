class Public::ItemsController < ApplicationController

def create
  @item = Item.new(item_params)
  @item.customer_id = current_customer.id
  if @item.save
  flash[:notice] = "You have created item successfully."
  redirect_to item_path(@item.id)
  else
  @customer = current_customer
  @items = item.all
  render :index
  end
end

def index
  @customer = current_customer
  @item = Item.new
  @items = Item.all
  @quantity = Item.count
end

def show
  @item = Item.find(params[:id])
  @customer = @book.customer
  @item_new = Item.new
end

def edit
  @item = Item.find(params[:id])
end

def update
  @item = Item.find(params[:id])
  if @item.update(item_params)
  flash[:notice] = "You have updated item successfully."
  redirect_to item_path(@item.id)
  else
  render :edit
  end
end

def destroy
  item = Item.find(params[:id])
  item.destroy
  redirect_to items_path
end

end

private

def item_params
  params.require(:item).permit(:title, :body)
end