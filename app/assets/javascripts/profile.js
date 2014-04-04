/* ZuulWeb 2.0 Profile Index profile.js JavaScript Document */

//expands the table row of class .hidden-row below
function expand() {
	var $this=$(this),
	that = $this.parent().parent()[0],
	isItem = false,
	$itemRows = $("#transactions > tbody > tr").filter(function() {
		if (this === that) {
			isItem = true;
			return false;
		} else if (!($(this).hasClass("item")) {
			isItem = false;
			return false;
		}
	return isItem;
	}).toggleClass("hidden-row");	
	$this.find("span").toggleClass("glyphicon-plus").toggleClass("glyphicon-minus");
	//TODO: expand functionality here
};

//sets up the event handlers
$(function() {
	var expandBtns = $(".expand").click(expand);
});
