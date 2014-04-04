/* ZuulWeb 2.0 Profile Index profile.js JavaScript Document */

//expands the table row of class .hidden-row below
function expand() {
	console.log(this.classList);
	this.innerHTML = '<span class="glyphicon glyphicon-minus"></span>';
	//TODO: expand functionality here
};

//sets up the event handlers
$(function() {
	var expandBtns = $(".expand").each(function() {
		this.click(expand);
	});
});
