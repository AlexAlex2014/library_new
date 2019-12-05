class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :toggle]


  def index
    @books = Book.all
    @user = current_user
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

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:image, :title, :author, :status, :user_id, :reader, :description)
  end
end
