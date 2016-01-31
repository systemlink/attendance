$(document).on 'ready page:load', =>
  if $('#works')[0]
    works = [].concat(
      {date: moment("201601#{('0' + day).slice(-2)}")} for day in [27..31],
      {date: moment("201602#{('0' + day).slice(-2)}")} for day in [1..29],
      {date: moment("201603#{('0' + day).slice(-2)}")} for day in [1..6]
    )
    new Vue
      el: '#works'
      data:
        year: 2016
        month: 1
        works:
          works
