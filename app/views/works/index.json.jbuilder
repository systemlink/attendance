json.works @works do |work|
  json.id          work.id
  json.started_at  work.started_at.strftime('%Y/%m/%d %H:%M')
  json.ended_at    work.ended_at.strftime('%Y/%m/%d %H:%M')
  json.times       work.times
  json.note        work.note
end
