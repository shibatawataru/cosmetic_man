class Public::CustomersController < ApplicationController
  before_action :ensure_current_customer, only: [:edit, :update]

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
      redirect_to public_customer_path
    else
      render :edit
    end
  end
  
  def withdrawal
    @customer = Customer.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

   private
   
  def ensure_current_customer
    if current_customer.id != params[:id].to_i
    flash[:notice]="権限がありません"
    redirect_to public_items_path
    end
  end

  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image)
  end
end
