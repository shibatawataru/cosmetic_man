class Admin::TagsController < ApplicationController

  def index
    @tags = Tag.all
    @Tag = Tag.new
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.save
    redirect_to admin_tags_path

  end

  def update
    @tag = Tag.find(params[:id])
    @tag.update(tag_params)
    redirect_to admin_tags_path
  end

  private

  def tag_params
    params.permit(:name)
  end

end