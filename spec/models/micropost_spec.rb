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
  
  before do
    @micropost = FactoryBot.create(:micropost)
  end

  describe 'Micropostの投稿'
  context '投稿が上手くいくとき' do
    it '正しく情報を入力できれば投稿できる' do
      expect(@micropost).to be_valid
    end
  end

  context '投稿がうまくいかないとき' do
    it 'contentが空だと投稿できない' do
      @micropost.content = nil
      @micropost.valid?
      expect(@micropost.errors.full_messages).to include("Content can't be blank")
    end
    it 'contentが141文字以上だと投稿できない' do
      # 141字のダミーデータ
      @micropost.content = 'この文章はダミーです。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。文字の大きさ、量、字間、
      行間等を確認するために入れています。この文章はダミーです。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。文字の大きさは'
      @micropost.valid?
      expect(@micropost.errors.full_messages).to include('Content is too long (maximum is 140 characters)')
    end
    it 'userに紐付いていないと投稿できない' do
      @micropost.user = nil
      @micropost.valid?
      expect(@micropost.errors.full_messages).to include('User must exist')
    end
    # expect(@user).not_to be_valid
  end
end
