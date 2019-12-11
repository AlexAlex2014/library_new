# frozen_string_literal: true

# class LikesController
class LikesController < ApplicationController

  def show
  end

  def edit
  end
  #
  # def create
  #   # @book = Book.find(params[:book_id])
  #   # @like = @book.likes.create(like_params)
  #   # @like.user_id = current_user.id
  #   # @like.save
  #
  #
  #   # render json: {like: @like}
  #   @book = Book.find(params[:id])
  #   @like = @book.likes.create(user_id: params[:user_id],
  #                              star: params[:star],
  #                              likable_id: params[:likable_id],
  #                              likable_type: params[:likable_type])
  #   @like.user_id = current_user.id
  #   @like.star = params[:like][:star]
  #   # byebug
  #
  #   @like.save
  #
  #   if @like.save
  #   else
  #     flash[:warning] = 'Something went wrong'
  #   end
  #   redirect_back(fallback_location: root_path)
  # end
  #
  #
  # def destroy
  #   @like = Like.find_by(id: params[:id])
  #   @like.destroy
  #   if @like.save
  #   else
  #     flash[:warning] = 'Something went wrong'
  #   end
  #   redirect_back(fallback_location: root_path)
  # end

  private

  def like_params
    params.require(:like).permit(:likable_id, :likable_type, :user_id, :star)
  end
end

