require 'rails_helper'

RSpec.describe "homes", type: :controller do
  let(:miketa_params) { { username: 'miketa-webprgr'} }

  describe HomesController do
    describe '#GET' do
      it "トップページを表示する" do
        get :show
        expect(response).to have_http_status(200)
      end

      it 'miketa-webprgrで検索すると検索結果が返ってくること' do
        get :show, params: miketa_params
        expect(response).to have_http_status(200)
      end

      it 'mockに置き換える' do
        mock = double('octokit')
        allow(Octokit::Client).to receive(:new).and_return(mock)
        expect(mock).to receive(:repositories).with('something')

        get :show, params: { username: 'something'}
        expect(response).to have_http_status(200)
      end
    end
  end
end
