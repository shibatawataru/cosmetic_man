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

  def destroy
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    flash.now[:alert] = '投稿を削除しました'
    #renderしたときに@postのデータがないので@postを定義
    @item = Post.find(params[:item_id])  
    render :item_comments  #render先にjsファイルを指定
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
