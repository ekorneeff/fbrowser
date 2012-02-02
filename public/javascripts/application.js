$(document).ready(function(){
  $(".panel a").live('click',function(){
    lnk = $(this);
    $.get(lnk.attr('href'), function(data){
      lnk.closest('.panel').html(data);
    });
    return false;
  });
});
