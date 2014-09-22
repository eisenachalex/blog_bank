// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
$(document).ready(function() {
  // Global search function (partial)
  $(document).on("click", "a.delete_post", function(e) {
  	e.preventDefault;
    var data = { post_id: $(this).attr("id")};
    $.post('/delete_post', data, function(response) {
    });
      $(this).closest(".post_preview").fadeOut();// This will work even if the no of
  });

  $(document).on("change", "#category_filter", function(e) {
    e.preventDefault;
    var value = $(this).val();
    console.log(value);
    url = "/filter_posts?filter=" + value
    $.get(url,function(response) {
      $("#wrapper").html(response);
    });
    //   $(this).closest(".post_preview").fadeOut();// This will work even if the no of
  });
  
  $(document).on("click", "a.edit_post", function(e) {
    e.preventDefault;
		var post_id = $(this).attr("id");
		var url = '/edit_post?post_id=' + post_id;
    $.get(url, function(response) {
    	 $("#post_side").html(response);
    });
  });
});