window.ViewModels = {}

$(document).on 'ready page:load', =>
  new ViewModels.Work(el: '#works') if $('#works')[0]
