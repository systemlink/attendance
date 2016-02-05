# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Work.delete_all
Work.create!(started_at: DateTime.new(2016, 2, 4, 9),
    ended_at: DateTime.new(2016, 2, 4, 18),
    times: 8,
    note: '勤務表システム作成')
