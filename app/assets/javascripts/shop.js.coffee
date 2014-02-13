# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(function() {
	$(".plus").click(function() {
		var text = $(this).next(":text");
		text.val(parseInt(text.val(), 10) + 1);
	});

	$(".minus").click(function() {
		var text = $(this).prev(":text");
		text.val(parseInt(text.val(), 10) - 1);
	});
});