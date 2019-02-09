require 'rails_helper'

RSpec.describe "clubs/show", type: :view do
  before(:each) do
    @club = assign(:club, Club.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
