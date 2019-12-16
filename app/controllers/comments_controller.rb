class CommentsController < ApplicationController
  before_action :set_book, only: [:new, :create, :destroy]

  def index
    @comments = Comment.order('created_at DESC')
  end

  def new
    @comment = @book.comments.new
  end

  def create
    @comment = @book.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
  end

  def destroy
    @comment = @book.comments.find(params[:id])
    @comment.destroy

    render json: {comment: @comment}
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
