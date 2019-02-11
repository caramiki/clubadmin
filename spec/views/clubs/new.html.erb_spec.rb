require "rails_helper"

RSpec.describe "clubs/new", type: :view do
  let(:club) { build(:club) }
  let(:user) { create(:user, :super_admin) }
  before(:each) { sign_in user }

  it "renders new club form" do
    render template: "clubs/new.html.erb", locals: { club: club }

    assert_select "form[action=?][method=?]", clubs_path, "post" do
    end
  end
end
