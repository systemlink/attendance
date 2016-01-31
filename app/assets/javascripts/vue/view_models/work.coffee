ViewModels.Work = Vue.extend
  data: ->
    year: moment().year()
    month: moment().month() + 1

  methods:
    next: ->
      next = @toMoment().add 1, 'months'
      @year = next.year()
      @month = next.month() + 1
    prev: ->
      prev = @toMoment().add -1, 'months'
      @year = prev.year()
      @month = prev.month() + 1
    dates: ->
      [].concat(
        @toMoment(2016, 1, date) for date in [27..31],
        @toMoment(2016, 2, date) for date in [1..29],
        @toMoment(2016, 3, date) for date in [1..6]
      )
    toMoment: (year = @year, month = @month, date = 1) ->
      moment("#{year}/#{month}/#{date}", 'YYYY/M/D')
