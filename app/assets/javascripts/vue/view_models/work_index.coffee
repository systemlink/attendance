# 勤務一覧
ViewModels.WorkIndex = Vue.extend
  data: ->
    year: moment().year()
    month: moment().month() + 1
    works: []

  ready: -> @getWorks()

  computed:
    # カレンダーに表示する日付一覧
    # @return {Array} 現在年月の日付一覧
    dates: ->
      cur = @startDate()
      result = [cur.clone()]
      while cur.diff(@endDate(), 'days') < 0
        cur.add 1, 'days'
        result.push cur.clone()
      result

  methods:
    # 次月イベント処理
    next: ->
      next = @toMoment().add 1, 'months'
      @year = next.year()
      @month = next.month() + 1
      @getWorks()
    # 前月イベント処理
    prev: ->
      prev = @toMoment().add -1, 'months'
      @year = prev.year()
      @month = prev.month() + 1
      @getWorks()
    # カレンダーの開始日付を返します
    startDate: ->
      date = @toMoment().startOf('month')
      startPosition = if date.day() == 0 then 6 else date.day() - 1
      date.subtract startPosition, 'days'
    # カレンダーの終了日付を返します
    endDate: ->
      date = @toMoment().endOf('month')
      endPosition = if date.day() == 0 then 0 else 7 - date.day()
      date.add endPosition, 'days'
    # 現在の年月からmomentオブジェクトを生成
    # @return {Moment} 現在年月。日にちは 1 固定　
    toMoment: ->
      moment("#{@year}/#{@month}/1", 'YYYY/M/D')
    # 登録済みかいなか
    isSettled: (date) ->
      ret = _.find @works, (work) =>
        moment(work.started_at, 'YYYY/M/D h:mm').format('YYYYMMDD') == date.format('YYYYMMDD')
      ret?
    # 登録済みの勤務データを取得
    getWorks: ->
      params =
        search_started_at: @startDate().format('YYYY/MM/DD')
        search_ended_at: @endDate().format('YYYY/MM/DD')
      $.ajax
        type: 'GET'
        url: '/works.json'
        data: params
        async: false
      .done (res) =>
        @works = res.works
    # 対象年月日の作業内容を取得
    getNote: (date) ->
      ret = _.find @works, (work) =>
        @isSettled(date)
      ret = if ret? then ret.note else ""
