require 'rails_helper'

RSpec.describe User, type: :model do
  describe '実際に保存してみる' do
  it "有効な投稿内容の場合は保存されるか" do
    expect(FactoryBot.build(:user)).to be_valid
  end
  end
  context "空白のバリデーションチェック" do
    it "nameが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
    user = User.new(name: '',email: 'fdfsdf@fdadf', password: '123456')
    expect(user).to be_invalid
    expect(user.errors[:name]).to include("は１文字以上入力してください。")
    end
    it "emailが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      user = User.new(name: 'fdfdfsda',email: '', password: '123456')
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("を入力してください")
    end
    it "passwordが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      user = User.new(name: 'fdfdfsda',email: 'fdsfd@fadfds', password: '')
      expect(user).to be_invalid
      expect(user.errors[:password]).to include("を入力してください")
    end
  end
end
