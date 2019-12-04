class SubscriptionsController < ApplicationController
  # before_action :set_book, :set_sub, only: [:show, :edit]


  def index
    @book = Book.find(params[:book_id])
    @sub = @book.subscriptions

    @subs = @book.subscriptions.all
    @users = User.all
    @subs_del = @book.subscriptions.deleted

    # raise ddd
    # @readers = []
    # @users.each do |user|
    #   @readers << user
    # end
  end

  def show
    # @book = Book.find(params[:book_id])
    # @sub = @book.subscriptions
    #
    # @users = User.all
    # @readers = []
    # @users.each do |user|
    #   raise fff
    #   @readers << user.id
    # end
  end

  def edit
  end

  def create
    @book = Book.find(params[:book_id])

    @sub = @book.subscriptions.create(article_params)

    # @sub = @book.subscriptions.create(user_id: params[:user_id],
    #                            reader: params[:reader],
    #                            subscriptionable_id: params[:subscriptionable_id],
    #                            subscriptionable_type: params[:subscriptionable_type])
    if @sub.save
    else
      flash[:warning] = 'Something went wrong'
    end
    redirect_back(fallback_location: root_path)
  end

  def update
    @sub = Subscription.find(params[:id])

    if @sub.update(article_params)
      redirect_to @sub
    else
      render 'edit'
    end
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
  # def set_book
  #   @book = Book.find(params[:id])
  # end
  #
  # def set_sub
  #   @sub = @book.subscription
  # end

  def article_params
    params.require(:subscription).permit(:user_id, :reader, :book_id)
  end
end
