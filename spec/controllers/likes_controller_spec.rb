require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:book) { create(:book, user_id: user.id, category_id: category.id) }
  let(:like) { create(:like, likable: book, user_id: user.id) }

  before do
    user.confirm
    sign_in user
    # @params = {
    #     id: like.id
    # }
  end

  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/likes').to route_to('likes#create')
    end
    it 'routes to #destroy' do
      expect(delete: "/likes/#{like.id}").to route_to('likes#destroy', id: "#{like.id}")
    end
  end
  #
  # context 'POST #create' do
  #   it 'create a new like' do
  #     expect {
  #       post :create, params: { user_id: user.id,
  #                               likable_id: image_bot.id,
  #                               likable_type: 'Image' }
  #     }.to change { Like.count }.by(1)
  #   end
  #   it "redirects to like's page if validations pass" do
  #     from(fallback_location: root_path)
  #     post :create, params: { user_id: user.id,
  #                             likable_id: image_bot.id,
  #                             likable_type: 'Image' }
  #     expect(response).to redirect_to(fallback_location: root_path)
  #   end
  # end
  #
  # context 'DELETE #destroy' do
  #   it 'should delete like' do
  #     expect { delete :destroy, params: @params }.to change(Like, :count).by(-1)
  #   end
  #   it "redirects to like's page if validations pass" do
  #     from(fallback_location: root_path)
  #     delete :destroy, params: @params
  #     expect(response).to redirect_to(fallback_location: root_path)
  #   end
  # end
end
