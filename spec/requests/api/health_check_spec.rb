require 'rails_helper'

RSpec.describe 'Api::HealthChecks', type: :request do
  describe 'GET /api/health_check' do
    it 'returns http success' do
      get '/api/health_check'
      expect(response).to have_http_status(:success)
    end
  end
end
