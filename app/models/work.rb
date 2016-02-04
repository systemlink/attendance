class Work < ActiveRecord::Base
  scope :search, -> (search_started_at, search_ended_at) {
    where(started_at: (DateTime.parse(search_started_at)..DateTime.parse(search_ended_at + " 23:59:59")))
  }
end
