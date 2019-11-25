class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]


  def index
    @books = Book.all
  end

  def show
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(article_params)
    @book.user_id = current_user.id
    @book.save

    if @book.save
      redirect_to @book
    else
      render 'new'
    end
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(article_params)
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    flash[:success] = 'Book deleted'
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def article_params
    params.require(:book).permit(:image, :name, :author, :status, :user_id)
  end
end
