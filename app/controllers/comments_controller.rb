class CommentsController < ApplicationController
  def index
    @comments = Comment.order('created_at DESC')
  end

  def new
    @book = Book.find(params[:book_id])
    @comment = @book.comments.new
  end

  def create
    @book = Book.find(params[:book_id])
    @comment = @book.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    # redirect_back(fallback_location: root_path)
  end

  def destroy
    @book = Book.find(params[:book_id])
    @comment = @book.comments.find(params[:id])
    @comment.destroy
    redirect_to book_path(@book)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
