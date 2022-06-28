class Public::CustomersController < ApplicationController

  def edit
    @customer = Customer.find(params[:id])
  end

  def show
    @customer = Customer.find(params[:id])
    @item = @customer.items
    #@item_tags = @item.tags
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to public_customer_path
    else
      render :edit
    end
  end

   private

  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image)
  end
end
