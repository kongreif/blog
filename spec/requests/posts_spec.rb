# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts' do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:post1) { create(:post) }
  let(:valid_post_params) do
    { post: { title: Faker::Lorem.word, content: Faker::Lorem.paragraph } }
  end
  let(:admin_alert) { 'You must be an admin to perform this action.' }
  let(:sign_in_alert) { 'You need to sign in or sign up before continuing.' }

  shared_context 'when admin is signed in' do
    before { sign_in admin }
  end

  shared_context 'when user is signed in' do
    before { sign_in user }
  end

  describe 'GET /new' do
    context 'when admin user is signed in' do
      include_context 'when admin is signed in'

      it 'returns http success' do
        get new_post_path
        expect(response).to have_http_status(:success)
      end
    end

    context 'when normal user is signed in' do
      include_context 'when user is signed in'

      it 'redirects user to roots_path' do
        get new_post_path
        expect(response).to redirect_to(root_path)
      end

      it 'shows correct alert' do
        get new_post_path
        expect(flash[:alert]).to match(admin_alert)
      end
    end

    context 'when user is not signed in' do
      it 'redirects user to login path' do
        get new_post_path
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'shows correct alert' do
        get new_post_path
        expect(flash[:alert]).to match(sign_in_alert)
      end
    end
  end

  describe 'POST /create' do
    context 'when admin user is signed in' do
      include_context 'when admin is signed in'

      it 'creates a new post and redirects to the posts show page' do
        expect do
          post posts_path, params: valid_post_params
        end.to change(Post, :count).by(1)

        expect(response).to redirect_to(post_path(Post.last))
      end
    end

    context 'when normal user is signed in' do
      include_context 'when user is signed in'

      it 'does not create post' do
        expect do
          post posts_path, params: valid_post_params
        end.not_to change(Post, :count)
      end

      it 'redirects user to root path' do
        post posts_path, params: valid_post_params
        expect(response).to redirect_to(root_path)
      end

      it 'shows correct alert' do
        get new_post_path
        expect(flash[:alert]).to match(admin_alert)
      end
    end

    context 'when user is not signed in' do
      it 'does not create post' do
        expect do
          post posts_path, params: valid_post_params
        end.not_to change(Post, :count)
      end

      it 'redirects user to login path' do
        get new_post_path
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'shows correct alert' do
        get new_post_path
        expect(flash[:alert]).to match(sign_in_alert)
      end
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
    context 'when admin user is signed in' do
      include_context 'when admin is signed in'

      it 'returns success' do
        get new_post_path
        expect(response).to have_http_status(:success)
      end
    end

    context 'when normal user is signed in' do
      include_context 'when user is signed in'

      it 'redirects user root path' do
        get new_post_path
        expect(response).to redirect_to(root_path)
      end

      it 'shows correct alert' do
        get new_post_path
        expect(flash[:alert]).to match(admin_alert)
      end
    end

    context 'when user is not signed in' do
      it 'redirects user login path' do
        get new_post_path
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'shows correct alert' do
        get new_post_path
        expect(flash[:alert]).to match(sign_in_alert)
      end
    end
  end

  describe 'GET /update' do
    context 'when admin user is signed in' do
      include_context 'when admin is signed in'

      it 'returns http success' do
        patch post_path(post1), params: valid_post_params
        expect(response).to redirect_to(post_path(post1))
      end

      it 'updates the post' do
        patch post_path(post1), params: valid_post_params
        expect(post1.reload.title).to eq(valid_post_params[:post][:title])
      end
    end

    context 'when normal user is signed in' do
      include_context 'when user is signed in'

      it 'redirects user root path' do
        patch post_path(post1), params: valid_post_params
        expect(response).to redirect_to(root_path)
      end

      it 'does not update the post' do
        patch post_path(post1), params: valid_post_params
        expect(post1.reload.title).not_to eq(valid_post_params[:post][:title])
      end

      it 'shows correct alert' do
        get new_post_path
        expect(flash[:alert]).to match(admin_alert)
      end
    end

    context 'when user is not signed in' do
      it 'redirects user to login path' do
        patch post_path(post1), params: valid_post_params
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'does not update the post' do
        patch post_path(post1), params: valid_post_params
        expect(post1.reload.title).not_to eq(valid_post_params[:post][:title])
      end

      it 'shows correct alert' do
        get new_post_path
        expect(flash[:alert]).to match(sign_in_alert)
      end
    end
  end
end
