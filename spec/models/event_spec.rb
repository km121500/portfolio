# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event,"モデルに関するテスト", type: :model do

  describe '実際に保存してみる' do
    before do
    FactoryBot.create(:user)
    end
  it "有効な投稿内容の場合は保存されるか" do
    expect(FactoryBot.build(:event)).to be_valid
  end
  end
  context "空白のバリデーションチェック" do
    it "titleが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
    event = Event.new(title: '', body: 'hoge',place: '場所', date: '日付',image: 'fakdjfkdjs')
    expect(event).to be_invalid
    expect(event.errors[:title]).to include("は１文字以上入力してください。")
    end

    it "bodyが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      event = Event.new(title: 'hoge', body: '',place: '場所', date: '日付',image: 'fakdjfkdjs')
      expect(event).to be_invalid
      expect(event.errors[:body]).to include("は１文字以上入力してください。")
    end
    
    it "placeが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      event = Event.new(title: 'hoge', body: 'body',place: '', date: '日付',image: 'fakdjfkdjs')
      expect(event).to be_invalid
      expect(event.errors[:place]).to include("は１文字以上入力してください。")
    end
    
    it "dateが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      event = Event.new(title: 'hoge', body: 'body',place: '場所', date: '',image: 'fakdjfkdjs')
      expect(event).to be_invalid
      expect(event.errors[:date]).to include("は１文字以上入力してください。")
    end
    
    it "imageが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      event = Event.new(title: 'hoge', body: 'body',place: '場所', date: 'date',image: '')
      expect(event).to be_invalid
      expect(event.errors[:image]).to include("を選択してください。")
    end
  end
  
end
