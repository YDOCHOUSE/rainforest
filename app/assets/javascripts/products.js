// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/



//below here we can listen for two events simply by seperating them by a space
//here we are listening to ready, and on page:load

$(document).on('page:load ready', function() {
  $('#search-form').submit(function(event) {
  	event.preventDefault();
  	var searchValue = $('#search').val();

  	$.getScript('/products?search=' + searchValue);
 });


//detects a scroll place close to the bottom grabs teh url
//makes an ajax request for the url we grabbed and places the next page on and on
  if ($('.pagination').length) {
    $(window).scroll(function() {
      var url = $('.pagination span.next').children().attr('href');
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
        $('.pagination').text("Fetching more products...");
        return $.getScript(url);
      }
    });
   }
  });