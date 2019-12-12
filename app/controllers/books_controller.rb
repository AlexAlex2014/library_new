class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :toggle]
  helper_method :sort_direction

  def index
    if params[:sort]
      @books = Book.order(params[:sort] + ' ' + sort_direction).page params[:page]
    else
      @books = Book.page params[:page]
    end

    @user = current_user

    # @books = Book.select('books.*, (COUNT(subscription.id)+COUNT(likes.id)) AS i').left_outer_joins(:subscription, :likes).group('books.id').order('i DESC') #.page(params[:page])
  end

  def show
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

    redirect_to books_path
  end

  def toggle
    @book = Book.find(params[:id])
    @book.update_attributes(:status => params[:status])
    render json: {book: @book}
  end

  def create_star
    @user = current_user
    @book = Book.find(params[:id])
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
    @book = Book.find(params[:id])
    user_like = find_user_lik(params[:like][:likable_id], params[:like][:likable_type])
    @like = @book.likes.find(user_like).update_attribute(:star, params[:like][:star])

    @book.rating = @book.likes.avg(:star).to_f
    @book.save

    render json: {like: @like}
  end

  private

  # def sort_column
  #   Book.column_names.include?(params[:sort]) ? params[:sort] : "title"
  # end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def find_user_lik(likable_id, likable_type)
    Like.find_by(likable_id: likable_id,
                 likable_type: likable_type, user_id: current_user.id)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:image, :title, :author, :status, :user_id, :reader, :description)
  end
end
