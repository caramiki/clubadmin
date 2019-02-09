require 'rails_helper'

RSpec.describe "clubs/new", type: :view do
  before(:each) do
    assign(:club, Club.new())
  end

  it "renders new club form" do
    render

    assert_select "form[action=?][method=?]", clubs_path, "post" do
    end
  end
end
