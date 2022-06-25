class Public::ItemsController < ApplicationController

  def new
    #中間テーブルを使用して、itemに紐づくtagを取得して、@itemに格納したい
      @item = Item.new(params[:id])
      @tags = Tag.all
  end

  def create
    @item = Item.new(item_params)
    @item.customer_id = current_customer.id
    #tag_list=params[:item][:name].split(',')
    if @item.save
      @item.save_tag(params[:item][:item_tags][:tag_id])
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
    # @item_tags = @item.tags
  end

  def edit
    @item = Item.find(params[:id])
    @tags = Tag.all
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      @item.save_tag(params[:item][:item_tags][:tag_id])
      flash[:notice] = "You have updated item successfully."
      redirect_to public_item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to public_items_path
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