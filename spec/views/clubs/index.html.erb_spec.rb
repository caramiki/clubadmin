require 'rails_helper'

RSpec.describe "clubs/index", type: :view do
  before(:each) do
    assign(:clubs, [
      Club.create!(),
      Club.create!()
    ])
  end

  it "renders a list of clubs" do
    render
  end
end
