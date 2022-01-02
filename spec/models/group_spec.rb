require 'rails_helper'

RSpec.describe group, type: :model do
  describe '実際に保存してみる' do
  it "有効な投稿内容の場合は保存されるか" do
    expect(FactoryBot.build(:group)).to be_valid
  end
  end
  context "空白のバリデーションチェック" do
    it "nameが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
    group = Group.new(name: '',introduction: 'fadfd')
    expect(group).to be_invalid
    expect(group.errors[:name]).to include("は１文字以上入力してください。")
    end
    it "emailが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      group = Group.new(name: 'jijij@',introduction: '')
      expect(group).to be_invalid
      expect(group.errors[:introduction]).to include("を入力してください")
    end
  end
end
