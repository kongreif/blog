# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pages' do
  describe 'GET /about' do
    it 'renders the about page' do
      get '/about'
      expect(response).to have_http_status(:ok)
    end
  end
end
