require "rails_helper"

RSpec.describe "clubs/edit", type: :view do
  let(:club) { create(:club) }
  let(:user) { create(:user, :super_admin) }
  before(:each) { sign_in user }

  it "renders the edit club form" do
    render template: "clubs/edit.html.erb", locals: { club: club }

    assert_select "form[action=?][method=?]", club_path(club), "post" do
    end
  end
end
