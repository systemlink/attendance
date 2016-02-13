window.ViewModels = {}
Vue.config.debug = false

$(document).on 'ready page:load', =>
  new ViewModels.WorkIndex(el: '#works_index') if $('#works_index')[0]
