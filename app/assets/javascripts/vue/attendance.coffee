window.ViewModels = {}
Vue.config.debug = false

$(document).on 'ready page:load', =>
  new ViewModels.WorkIndex(el: '#works_index') if $('#works_index')[0];
  new ViewModels.WorkNew(el: '#works_new') if $('#works_new')[0];
