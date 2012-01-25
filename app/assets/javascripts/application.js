//= require jquery
//= require jquery_ujs
//= require_self
//= require_tree .

$(document).ready(function(){
  $("a.make-input").click(function(){
    target = $(this).attr('data-make-input');
    target = $("#"+target);
    $(this).remove();
    if(target.length > 0)
    {
      input = $("<input />");
      input.attr('type', 'text');
      input.attr('name', target.attr('name'));
      input.attr('id', target.attr('id'));
      input.val(target.val());
      target.replaceWith(input);
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
});