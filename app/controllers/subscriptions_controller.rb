# frozen_string_literal: true

# class SubscriptionsController
class SubscriptionsController < ApplicationController
  before_action :set_book, only: %i[index show edit create]

  def index
    @sub = @book.subscriptions
    @subs = @book.subscriptions.all
    @users = User.all
    @subs_del = @book.subscriptions.deleted
  end

  def create
    @sub = @book.subscriptions.create(subscription_params)

    if @sub.save
    else
      flash[:warning] = 'Something went wrong'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @sub = Subscription.find_by(id: params[:id])
    @sub.destroy
    if @sub.save
    else
      flash[:warning] = 'Something went wrong'
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def subscription_params
    params.require(:subscription).permit(:user_id, :reader, :book_id)
  end
end
