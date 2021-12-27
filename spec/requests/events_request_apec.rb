require 'rails_helper'

RSpec.describe "eventコントローラーのテスト", type: :request do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  describe 'ログイン済み' do
    before do
      sign_in user
    end
    context "ユーザーの投稿一覧ページが正しく表示される" do
      before do
        get users_path(user)
      end
    end
  end
  describe '非ログイン' do
    context "投稿一覧ページへ遷移されない" do
      before do
        get root_path
      end
    end
  end


  # get admins_posts_path(admin)であればパスワードが違うため401エラーであり、
  # get admins_posts_pathであれば302のリダイレクトになるため、テストしたい方で記述してください。

  # describe '非ログイン' do
  #   context "投稿一覧ページへ遷移されない" do
  #     before do
  #       get admins_posts_path
  #     end
  #     it 'リクエストは302 OKとなること' do
  #       expect(response.status).to eq 302
  #     end
  #   end
  # end
end