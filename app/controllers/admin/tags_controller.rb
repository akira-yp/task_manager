class Admin::TagsController < ApplicationController

  def new
    @tag = Tag.new
    @tags = Tag.all
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to new_admin_tag_path
    else
      render :new
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    if @tag.destroy
      redirect_to new_admin_tag_path, notice:"#{@tag.name}タグを削除しました"
    else
      render :new
    end
  end

  private
  def tag_params
    params.require(:tag).permit(:name)
  end
end
