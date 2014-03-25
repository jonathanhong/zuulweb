/* ZuulWeb 2.0 Shop Index shop.js JavaScript Document */

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
