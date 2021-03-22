# 微妙すぎるのでボツ。参考にしないでください。

require 'rails_helper'

RSpec.describe "homes", type: :request do
  let(:miketa_params) { { username: 'miketa-webprgr'} }
  let(:dyson_params) { { username: 'dyson-dyson' } }

  let!(:users) { User.create(name: 'testuser', html_url: 'www.yahoo.co.jp') }

  describe "トップページ関係" do
    it 'ログイン画面の表示に成功すること' do
      get root_path
      expect(response).to have_http_status(200)
    end

    it 'miketa-webprgrで検索すると検索結果が返ってくること', :vcr do
      get root_path, params: miketa_params
      expect(response).to have_http_status(200)
    end

    # そもそもresponseが返ってきていない問題
    xit 'dysonで検索するとエラーになること' do
      get root_path, params: dyson_params
      expect(response).to raise_error
    end

    it 'mockに置き換える' do
      mock = double('octokit')
      allow(Octokit::Client).to receive(:new).and_return(mock)
      expect(mock).to receive(:repositories).with('something').and_return(User.all)

      get root_path, params: { username: 'something'}
      expect(response).to have_http_status(200)
    end
  end
end
