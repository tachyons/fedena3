// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

document.observe("dom:loaded", function() {
    $$('object').each(function(obj){
        a  = document.createElement('param');
        a.name = 'wmode';
        a.value = 'transparent';
        obj.appendChild(a);
    });

    load_menu_from_plugins();
});
$(function() {
  $('[data-remote][data-replace]')
    .data('type', 'html')
    .live('ajax:success', function(event, data) {
      var $this = $(this);
      $($this.data('replace')).html(data);
      $this.trigger('ajax:replaced');
    });
});