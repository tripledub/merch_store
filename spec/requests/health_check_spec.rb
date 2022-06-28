require 'rails_helper'

RSpec.describe 'HealthChecks', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/health_check/index'
      expect(response).to have_http_status(:success)
    end
  end
end
