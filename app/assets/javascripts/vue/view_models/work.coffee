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
      cur = @toMoment().startOf('month')
      startPosition = if cur.day() == 0 then 6 else cur.day() - 1
      cur.subtract startPosition, 'days'
      endDate = @toMoment().endOf('month')
      endPosition = if endDate.day() == 0 then 0 else 7 - endDate.day()
      endDate.add endPosition, 'days'
      result = []
      until cur.diff(endDate, 'days') > 0
        result.push cur.clone()
        cur.add 1, 'days'
      result
    toMoment: (year = @year, month = @month, date = 1) ->
      moment("#{year}/#{month}/#{date}", 'YYYY/M/D')
