# 勤務登録
ViewModels.WorkNew = Vue.extend
  data: ->
    startDate: null
    startDateTime: null
    endDate: null
    endDateTime: null
    note: ""

  methods:
    # 引数の日付時刻からmomentオブジェクトを生成
    # @return {Moment} 日付時刻
    toMoment: (date, datetime) ->
      moment(date + " " + datetime)

    # 勤務データを作成
    setWorks: ->

      started_dateTime = @toMoment(@startDate, @startDateTime)
      ended_dateTime = @toMoment(@endDate, @endDateTime)
      params =
          'work' :
            started_at: started_dateTime.format('YYYY/MM/DD H:mm')
            ended_at: ended_dateTime.format('YYYY/MM/DD H:mm')
            times:ended_dateTime.diff(started_dateTime, 'hours')
            note:@note

      $.ajax({
         type: 'POST',
         url: '/works.json'
         data: params
      });
