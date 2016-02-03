# 勤務一覧
ViewModels.WorkIndex = Vue.extend
  data: ->
    year: moment().year()
    month: moment().month() + 1

  methods:
    # 次月イベント処理
    next: ->
      next = @toMoment().add 1, 'months'
      @year = next.year()
      @month = next.month() + 1
    # 前月イベント処理
    prev: ->
      prev = @toMoment().add -1, 'months'
      @year = prev.year()
      @month = prev.month() + 1
    # カレンダーに表示する日付一覧
    # @return {Array} 現在年月の日付一覧
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
    # 現在の年月からmomentオブジェクトを生成
    # @return {Moment} 現在年月。日にちは 1 固定　
    toMoment: ->
      moment("#{@year}/#{@month}/1", 'YYYY/M/D')
