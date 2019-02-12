require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe "#help" do
    it "responds successfully" do
      get :help
      expect(response).to be_success
    end
    
    it "returns a 200 response" do
      get :help
      expect(response).to have_http_status "200"
    end
  end

end
