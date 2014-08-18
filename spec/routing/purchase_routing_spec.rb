require 'spec_helper'

describe PurchaseController do
  describe 'routing' do
    it 'route to purchase path' do
      post('/documents/access/123abc/purchase').should route_to('purchase#create', key: '123abc')
    end
  end
end
