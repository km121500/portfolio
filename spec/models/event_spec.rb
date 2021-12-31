# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe '実際に保存してみる' do
  it "有効な投稿内容の場合は保存されるか" do
    expect(FactoryBot.build(:event)).to be_valid
  end
  end
  context "空白のバリデーションチェック" do
    it "titleが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
    event = Event.new(title: '', body:'hoge')
    expect(event).to be_invalid
    expect(event.errors[:title]).to include("タイトル")
    end
    it "bodyが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      event = Event.new(title: 'hoge', body: '')
      expect(event).to be_invalid
      expect(event.errors[:body]).to include("説明")
    end
  end
end
