class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :toggle, :update_star, :toggle, :create_star]
  before_action :set_categories, only: [:new, :create, :edit, :update]
  helper_method :sort_direction

  def index
    if params[:sort]
      @books = Book.order(params[:sort] + ' ' + sort_direction).page params[:page]
    else
      @books = Book.page params[:page]
    end
    @books_rate = Book.order('rating DESC').limit(6)

    @user = current_user
  end

  def show
    @subs = @book.subscriptions.all
    @subs_del = @book.subscriptions.deleted

    @comments = @book.comments.order('created_at DESC')
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save

    if @book.image.model[:image].nil?
      file = File.open('./app/assets/images/default.png')
      @book.image = file
    end
    @book.save

    if @book.save
      redirect_to @book
    else
      render 'new'
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    flash[:success] = 'Book deleted'

    render json: { success: true }
  end

  def toggle
    @book.update_attributes(:status => params[:status])
    render json: {book: @book}
  end

  def create_star
    @user = current_user
    @like = @book.likes.create(user_id: params[:user_id],
                               star: params[:star],
                               likable_id: params[:likable_id],
                               likable_type: params[:likable_type])
    @like.user_id = current_user.id
    @like.star = params[:like][:star]
    @like.save

    @book.rating = @book.likes.avg(:star).to_f
    @book.save

    render json: {like: @like}
  end

  def update_star
    @user = current_user
    user_like = find_user_lik(params[:like][:likable_id], params[:like][:likable_type])
    @like = @book.likes.find(user_like).update_attribute(:star, params[:like][:star])

    @book.rating = @book.likes.avg(:star).to_f
    @book.save

    render json: {like: @like}
  end

  private

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : 'asc'
  end

  def find_user_lik(likable_id, likable_type)
    Like.find_by(likable_id: likable_id,
                 likable_type: likable_type, user_id: current_user.id)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end

  def book_params
    params.require(:book).permit(:image, :title, :author, :status, :user_id, :reader, :description, :category_id)
  end
end
