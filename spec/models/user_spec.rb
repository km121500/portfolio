require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with a name, email,password and password_confirmation" do
    expect(build(:user)).to be_valid
  end
end
