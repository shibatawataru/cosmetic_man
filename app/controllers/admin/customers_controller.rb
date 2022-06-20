class Admin::CustomersController < ApplicationController
  
  def index
    @items = Item.all
  end
  
  def show
    @customer = Customer.find(params[:id])
    @item = @customer.items
    #@item_tags = @item.tags
  end

  def customer_params
    params.require(:customer).permit(:name)
  end
end