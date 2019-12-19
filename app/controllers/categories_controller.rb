class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  helper_method :sort_direction

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.save

    if @category.image.model[:image].nil?
      file = File.open('./app/assets/images/default.png')
      @category.image = file
    end
    @category.save

    if @category.save
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def show
    @books = @category.books.all
    @user = current_user
  end

  def edit
  end

  def uprate
    if @category.update(category_params)
      redirect_to @category
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    flash[:success] = 'Category deleted'

    render json: { success: true }
  end

  def subjects
    @user = current_user
    if params[:sort]
      @categories = Category.order(params[:sort] + ' ' + sort_direction)
      @author_book = Book.order(params[:sort] + ' ' + sort_direction).group_by {|d| d.author }
      @status_book = Book.order(params[:sort] + ' ' + sort_direction).group_by {|d| d.status }
    else
      @categories = Category.all
      @author_book = Book.all.group_by {|d| d.author }
      @status_book = Book.all.group_by {|d| d.status }
    end
  end

  # def author_book(author)
  #   Book.where("author = ?", author)
  # end

  private

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : 'asc'
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :image)
  end
end
