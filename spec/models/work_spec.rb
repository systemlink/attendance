require 'rails_helper'

RSpec.describe Work, type: :model do
  describe '#scope' do
    it '#search' do
      result = Work.where(started_at: (DateTime.parse('2016/2/1 00:00')..DateTime.parse('2016/2/28 23:59:59'))).to_sql
      expect(Work.search('2016/2/1', '2016/2/28').to_sql).to eq result
    end
  end
end
