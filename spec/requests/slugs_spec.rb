require 'rails_helper'

RSpec.describe "Slugs", type: :request do
  describe "GET /slugs" do
    it "works! (now write some real specs)" do
      get slugs_path
      expect(response).to have_http_status(200)
    end
  end
end
