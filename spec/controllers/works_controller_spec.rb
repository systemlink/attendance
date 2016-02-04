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
end
