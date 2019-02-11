require "rails_helper"

RSpec.describe "clubs/index", type: :view do
  let(:clubs) { create_list(:club, 3) }
  let(:user) { create(:user, :super_admin) }
  before(:each) { sign_in user }

  it "renders a list of clubs" do
    render template: "clubs/index.html.erb", locals: { clubs: clubs }
  end
end
