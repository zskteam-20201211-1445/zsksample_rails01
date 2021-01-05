require 'rails_helper'

RSpec.describe Micropost, type: :model do
  describe '画像アップロード機能' do
    before do
      @micropost = FactoryBot.create(:micropost)
    end
    # 画像無しの場合
    context '画像無しの場合' do
      # 投稿が保存される事(#new)
      it '投稿が保存される事' do
        visit new_micropost_path
        fill_in 'Content', with: @micropost.content
        fill_in 'User', with: @micropost.user_id
        click_on 'Create Micropost'
        expect(response).to redirect_to Micropost.last
      end
      # 投稿を参照できる事(#show)
      it '投稿を参照できる事' do
      end
    end
    # 画像ありの場合
    context '画像ありの場合' do
      before do
        @micropost.image = fixture_file_upload('app/assets/images/aiueo.png')
      end
      # 対応するデータ型の時
      context '対応するデータ型の時' do
        # 投稿が保存されること(#new)
        it '投稿が保存されること' do
        end
        # 参照画面で画像が正しくリサイズされる事(#show)
        it '参照画面で画像が正しくリサイズされる事' do
        end
      end
      # 対応不可データ型の場合
      context '対応不可データ型の場合' do
        # 投稿が保存されない事(エラー確認)
        it '投稿が保存されない事' do
        end
      end
    end
  end
end
