# frozen_string_literal: true

# class CategoriesController
class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]
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
      @category.image = File.open('./app/assets/images/default.png')
    end
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

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to @category
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    flash[:success] = 'Category deleted'

    redirect_back(fallback_location: root_path)
  end

  def subjects
    @books = Book.all

    @user = current_user
    if params[:sort]
      @categories = Category.order(params[:sort] + ' ' + sort_direction)
      @author_book = Book.order(params[:sort] + ' ' + sort_direction)
                         .group_by(&:author)
      @status_book = Book.order(params[:sort] + ' ' + sort_direction)
                         .group_by(&:status)
    else
      @categories = Category.includes(:books).all
      @author_book = Book.all.group_by(&:author)
      @status_book = Book.all.group_by(&:status)
    end
    @data = []
    @data << ['Task', 'Hours per Day']
    @categories.to_a.each do |categor_book|
      @data << [categor_book.name, categor_book.books.size]
    end
  end

  private

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :image)
  end
end
