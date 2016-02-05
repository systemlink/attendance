window.ViewModels = {}
Vue.config.debug = false

$(document).on 'ready page:load', =>
  new ViewModels.WorkIndex(el: '#works') if $('#works')[0]
