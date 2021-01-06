require 'rails_helper'

RSpec.feature '/micropost#new', type: :feature do
  describe '画像アップロード機能' do
    background do
      @micropost = FactoryBot.create(:micropost)
    end
    context '画像無しの場合' do
      scenario '投稿が保存/参照できる事' do
        visit new_micropost_path

        expect(-> {
          fill_in 'Content', with: @micropost.content
          # select(value = @micropost.user_id.to_s, from: 'User')
          select(@micropost.user_id.to_s, from: 'User')
          click_on 'Create Micropost'
        }).to change(Micropost, :count).by(1)

        expect(current_path).to eq micropost_path(Micropost.last)
        expect(page).to have_content 'Micropost was successfully created.'
        expect(page).to have_selector 'p', text: @micropost.content
        expect(page).to have_selector 'p', text: @micropost.user_id
        expect(page).to have_no_selector 'img'
      end
    end

    context '画像ありの場合' do
      context '対応するサイズ/拡張子の場合' do
        background do
          @valid_image = "spec/fixtures/files/image#{rand(1..3)}.jpg"
        end
        scenario '投稿が保存/参照できる事' do
          visit new_micropost_path

          expect(-> {
            fill_in 'Content', with: @micropost.content
            # select(value = @micropost.user_id.to_s, from: 'User')
            select(@micropost.user_id.to_s, from: 'User')
            attach_file 'Image', @valid_image
            click_on 'Create Micropost'
          }).to change(Micropost, :count).by(1)

          expect(current_path).to eq micropost_path(Micropost.last)
          expect(page).to have_content 'Micropost was successfully created.'
          expect(page).to have_selector 'p', text: @micropost.content
          expect(page).to have_selector 'p', text: @micropost.user_id
          expect(page).to have_selector 'img'
        end
      end

      context '非対応サイズの場合' do
        background do
          @invalid_image = "spec/fixtures/files/image_large#{rand(1..3)}.jpg"
        end
        scenario '投稿が保存されない事' do
          visit new_micropost_path

          fill_in 'Content', with: @micropost.content
          # select(value = @micropost.user_id.to_s, from: 'User')
          select(@micropost.user_id.to_s, from: 'User')
          attach_file 'Image', @invalid_image
          click_on 'Create Micropost'

          expect(page).to have_content 'は5MB以内にしてください'
        end
      end

      context '非対応拡張子の場合' do
        background do
          files = %w[file1.zip file2.pdf file3.rtf]
          @invalid_file = "spec/fixtures/files/#{files[rand(0..2)]}"
        end
        scenario '投稿が保存されない事' do
          visit new_micropost_path

          fill_in 'Content', with: @micropost.content
          # select(value = @micropost.user_id.to_s, from: 'User')
          select(@micropost.user_id.to_s, from: 'User')
          attach_file 'Image', @invalid_file
          click_on 'Create Micropost'

          expect(page).to have_content 'は画像形式でアップロードしてください'
        end
      end
    end
  end
end
