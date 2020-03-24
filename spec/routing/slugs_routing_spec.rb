require "rails_helper"

RSpec.describe SlugsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/slugs").to route_to("slugs#index")
    end

    it "routes to #show" do
      expect(get: "/slugs/1").to route_to("slugs#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/slugs").to route_to("slugs#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/slugs/1").to route_to("slugs#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/slugs/1").to route_to("slugs#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/slugs/1").to route_to("slugs#destroy", id: "1")
    end
  end
end
