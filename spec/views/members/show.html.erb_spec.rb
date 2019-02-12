require "rails_helper"

RSpec.describe "members/show", type: :view do
  let(:club) { create(:club) }
  let(:member) { create(:member) }
  let(:user) { create(:user, :super_admin) }
  before(:each) { sign_in user }

  it "renders the member view" do
    render template: "members/show.html.erb", locals: { club: club, member: member }
  end
end
