# frozen_string_literal: true

# class LikesController
class LikesController < ApplicationController
  # after_action :likes, only: [:create]
  # after_action :unlikes, only: [:destroy]

  def create
    @like = Like.create(user_id: params[:user_id],
                        likable_id: params[:likable_id],
                        likable_type: params[:likable_type])
    if @like.save
    else
      flash[:warning] = 'Something went wrong'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find_by(id: params[:id])
    @like.destroy
    if @like.save
    else
      flash[:warning] = 'Something went wrong'
    end
    redirect_back(fallback_location: root_path)
  end

  # def likes
  #   return unless user_signed_in?
  #
  #   Action.new(user_id: current_user.id,
  #              action: 'likes',
  #              action_path: request.original_url).save
  # end
  #
  # def unlikes
  #   return unless user_signed_in?
  #
  #   Action.new(user_id: current_user.id,
  #              action: 'unlikes',
  #              action_path: request.original_url).save
  # end
end

