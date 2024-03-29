require "spec_helper"

describe DocumentsController do
  describe "routing" do

    it "routes to #index" do
      get("/documents").should route_to("documents#index")
    end

    it "routes to #new" do
      get("/documents/new").should route_to("documents#new")
    end

    it "routes to #show" do
      get("/documents/1").should route_to("documents#show", :id => "1")
    end

    it "routes to #edit" do
      get("/documents/1/edit").should route_to("documents#edit", :id => "1")
    end

    it "routes to #create" do
      post("/documents").should route_to("documents#create")
    end

    it "routes to #update" do
      put("/documents/1").should route_to("documents#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/documents/1").should route_to("documents#destroy", :id => "1")
    end

    it 'routes to #email_blueprint' do
      patch("/documents/email_blueprint").should route_to("documents#email_blueprint")
      post("/documents/email_blueprint").should route_to("documents#email_blueprint")
    end

    it 'route to #email' do
      get('/documents/1/email').should route_to('documents#email', id: '1')
    end

    it 'route to public document page' do
      get('/documents/access/123abc').should route_to('documents#public_access', key: '123abc')
    end
  end
end
