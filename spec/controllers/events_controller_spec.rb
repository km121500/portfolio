require 'rails_helper'

Rspec.describe EventsController, type: :controller do
describe '四則演算' do
  include LoginHelper
  
  let(:user) {FactoryBot.create(:user, email: 'a@example.com',password: '123456')}
  
  it "get new" do
    get :new
    expect(response.status).to eq(200)
  end
end
end