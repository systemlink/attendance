require 'rails_helper'

RSpec.describe WorksController, type: :controller do
  shared_examples_for 'リクエストが正常であること' do
    it { expect(response.body).to match_json_expression(subject) }
    it { expect(response).to be_success }
  end

  describe 'GET /works.json' do
    let!(:work) { create(:work) }
    let(:started_at) { work.started_at }
    before { get :index, params.merge({format: 'json'}) }

    context '対象データがある場合' do
      let(:params) {
        {
          search_started_at: started_at.strftime('%Y/%m/%d'),
          search_ended_at: (started_at + 30.day).strftime('%Y/%m/%d')
        }
      }
      subject {
        {
          works: [
            id: work.id,
            started_at: started_at.strftime('%Y/%m/%d %H:%M'),
            ended_at: work.ended_at.strftime('%Y/%m/%d %H:%M'),
            times: work.times,
            note: work.note
          ]
        }
      }
      it_behaves_like 'リクエストが正常であること'
    end

    context '対象データがない場合' do
      let(:params) {
        {
          search_started_at: (started_at + 1.month).strftime('%Y/%m/%d'),
          search_ended_at: (started_at + 1.month).strftime('%Y/%m/%d')
        }
      }
      subject {
        { works: [] }
      }
      it_behaves_like 'リクエストが正常であること'
    end
  end

  describe 'POST /works.json' do

    context 'パラメータが正しいとき' do
      before do
        work_attrs = attributes_for(:work)
        work_attrs[:started_at] = work_attrs[:started_at].strftime('%Y/%m/%d %H:%M')
        work_attrs[:ended_at] = work_attrs[:ended_at].strftime('%Y/%m/%d %H:%M')
        @params = { work: work_attrs }
      end

      it '201 「勤務データを作成しました。」 が返ってくる' do
        post :create, @params.merge({format: 'json'})
        expect(response).to be_success
        expect(response.status).to eq(201)
      end

      it '勤務テーブルの件数が１件増える' do
        expect {
          post :create, @params.merge({format: 'json'})
        }.to change(Work, :count).by(1)
      end
    end

    context 'パラメータが正しくないとき' do
      before do
        @params =
        { work:
          {}
       }
      end

      it '400 「不正なリクエストです。」が返ってくる' do
        post :create, @params.merge({format: 'json'})
        expect(response).not_to be_success
        expect(response.status).to eq(400)
      end

      it '勤務テーブルの件数が増えない' do
        expect {
          post :create, @params.merge({format: 'json'})
        }.not_to change(Work, :count)
      end

    end
  end
end
