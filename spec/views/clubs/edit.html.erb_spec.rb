require 'rails_helper'

RSpec.describe "clubs/edit", type: :view do
  before(:each) do
    @club = assign(:club, Club.create!())
  end

  it "renders the edit club form" do
    render

    assert_select "form[action=?][method=?]", club_path(@club), "post" do
    end
  end
end
