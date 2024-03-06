# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts' do
  let(:post1) { create(:post) }
  let(:valid_post_params) do
    { post: { title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph } }
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_post_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'creates a new post and redirects to the posts show page' do
      expect do
        post posts_path, params: valid_post_params
      end.to change(Post, :count).by(1)

      expect(response).to redirect_to(post_path(Post.last))
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get post_path(post1)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /index' do
    it 'returns http success' do
      get posts_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get edit_post_path(post1)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /update' do
    it 'returns http success' do
      patch post_path(post1), params: valid_post_params
      expect(response).to redirect_to(post_path(post1))
    end
  end
end
