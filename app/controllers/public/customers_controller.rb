class Public::CustomersController < ApplicationController

  def edit
    @customer = Customer.find(params[:id])
  end

  def show
    @customer = Customer.find(params[:id])
    @item = @customer.items
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy

  end

   private

  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image)
  end
end
