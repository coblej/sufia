require 'spec_helper'

describe Sufia::Pageview do
  before do
    @pageview = Sufia::Pageview
  end

  it 'has a pageviews metric' do
    expect(@pageview.metrics).to be  == Legato::ListParameter.new(:metrics, [:pageviews])
  end

  it 'has a date dimension' do
    expect(@pageview.dimensions).to be == Legato::ListParameter.new(:dimensions, [:date])
  end

  it 'responds to :for_path' do
    expect(@pageview).to respond_to(:for_path)
  end
end
