require 'spec_helper'

describe 'currency input type' do
  before do
    concat input_for(:foo, :price, as: :currency)
  end

  it 'add $ sign with add-on class' do
    assert_select '.add-on', content: '$'
  end

  it 'add currency class to input' do
    assert_select 'input.currency', count: 1
  end
end
