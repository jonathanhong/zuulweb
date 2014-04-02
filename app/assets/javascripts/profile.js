# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
function expand() {
	this.innerHTML = '<span class="glyphicon glyphicon-minus"></span>';
	#TODO: expand functionality here
}

window.onload = function() {
	var expandBtns = document.getElementsByClass("expand");
	for (var i = 0; i < expandButtons.length; i++) {
		expandBtns[i].onclick = expand();
	}
}
