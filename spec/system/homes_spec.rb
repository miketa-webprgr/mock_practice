require 'rails_helper'

RSpec.describe 'Homes', type: :system do
  context '実際にGitHubのAPIを叩く場合', :vcr do
    it 'ユーザー登録ができること' do
      visit root_path
      fill_in 'ユーザー名', with: 'miketa-webprgr'
      click_button '検索'
      expect(page).to have_content '275385114'
      expect(page).to have_content 'instagram_clone'
    end
  end

  context 'モックに置き換える場合' do
    # 苦肉の策として、わざわざusersテーブルとuserモデルを作りました
    # system specなので、view側で何かしらeachで回した時にエラーにならないものを作る必要がある
    let!(:users) { User.create(name: 'testuser', html_url: 'www.yahoo.co.jp') }

    it '検索するとOctokitのrepositoriesメソッドが走ること' do
      mock = double('octokit')
      allow(Octokit::Client).to receive(:new).and_return(mock)
      allow(mock).to receive(:repositories).with('something').and_return(User.all)

      visit root_path
      fill_in 'ユーザー名', with: 'something'
      click_button '検索'
      expect(page).to have_content 'testuser'
      expect(page).to have_content 'www.yahoo.co.jp'
    end
  end
end