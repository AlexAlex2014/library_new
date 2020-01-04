require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:book) { create(:book, user_id: user.id, category_id: category.id) }
  let(:like) { create(:like, likable: book, user_id: user.id) }

  before do
    user.confirm
    sign_in user
  end

  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/likes').to route_to('likes#create')
    end
    it 'routes to #destroy' do
      expect(delete: "/likes/#{like.id}").to route_to('likes#destroy', id: "#{like.id}")
    end
  end
end
