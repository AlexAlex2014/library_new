module BooksHelper
  def find_user_like(likable_id, likable_type)
    Like.find_by(likable_id: likable_id,
                 likable_type: likable_type, user_id: current_user.id)
  end
end
