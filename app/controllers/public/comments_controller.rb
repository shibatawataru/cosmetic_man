class Public::CommentsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @comment = current_customer.comments.new(comment_params)
    @comment.item_id = @item.id
    if @comment.save
       flash.now[:notice] = 'コメントを投稿しました'
      render :item_comments  #render先にjsファイルを指定
    else
      render :error
    end
  end

  def update

  end

  def destroy
    Comment.find_by(id: params[:id], item_id: params[:item_id]).destroy
    flash.now[:alert] = 'コメントを削除しました'
    #renderしたときに@postのデータがないので@postを定義
    @item = Item.find(params[:item_id])
    render :item_comments  #render先にjsファイルを指定
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content)
  end
end
