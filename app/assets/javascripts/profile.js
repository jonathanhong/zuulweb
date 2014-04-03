/* ZuulWeb 2.0 Profile Index profile.js JavaScript Document */

//expands the table row of class .hidden-row below
function expand() {
	this.innerHTML = '<span class="glyphicon glyphicon-minus"></span>';
	//TODO: expand functionality here
};

//sets up the event handlers
window.onload = function() {
	var expandBtns = document.getElementsByClass("expand");
	for (var i = 0; i < expandButtons.length; i++) {
		expandBtns[i].onclick = expand();
	}
};
