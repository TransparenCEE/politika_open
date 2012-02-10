//= require jquery
//= require jquery_ujs
//= require_self
//= require_tree .

$(document).ready(function(){
  $("a.make-input").click(function(){
    target = $(this).attr('data-make-input');
    target = $("#"+target);
    if(target.length > 0)
    {
      if(target.is('input')) {
        input = $("<select />");
        input.attr('name', target.attr('name'));
        input.attr('id', target.attr('id'));
        input.options = [];
        $.each($.parseJSON($(this).attr('data-make-collection')), function(index, value) {
          if(value == null)
            value = '';
          input.append($("<option></option>").attr("value",value).text(value));
        });
        input.val(target.val());
        target.replaceWith(input);
      } else {
        input = $("<input />");
        input.attr('type', 'text');
        input.attr('name', target.attr('name'));
        input.attr('id', target.attr('id'));
        input.val(target.val());
        target.replaceWith(input);
      }
    };
    
  });
  
  $("form ul li.form_row").find("input, select, textarea").focus(function(){
    $(this).parents("li.form_row").find("p.description").fadeIn();
  });
  
  $("form ul li.form_row").find("input, select, textarea").blur(function(){
    $(this).parents("li.form_row").find("p.description").fadeOut();
  });
  
  $("select.bound").each(function(){
    var bound = $(this);
    var bound_to = $("#" + $(this).attr("data-bound-to"));
    var children = $(bound).children();
    bound_to.change(function(){
      bound.find("optgroup").remove();
      var selected_children = $.grep(children, function(i){
        if($(i).attr('label') == bound_to.val()) {
          return true;
        } else {
          return false;
        }
      });
      $(selected_children).appendTo(bound);
    });
    if(bound_to.val() != "") {
      bound_to.trigger("change");
    }
  });
  
  $(".clone_height").each(function(c, i){
    var self_height = $(i).outerHeight();
    var target = $(i).attr("data-clone-weight-from");
    var target_height = $(target).outerHeight();
    if(target_height > self_height)
    {
      $(i).height(target_height);
    };
  });
  
  $('.toggler').click(function() {
    $('.hidden').toggle();
    return false;
  });
  
  $('.radio_button_checkbox').click(function() {
    var checked = $(this);
    $('.radio_button_checkbox').each(function() {
      if ($(this).hasClass(checked.attr('class')) && (checked.attr('id') != $(this).attr('id'))) {
        $(this).attr('checked', false);
      }
    });
  });
});