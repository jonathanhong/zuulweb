/* ZuulWeb 2.0 Shop Index shop.js JavaScript Document */

$(function() {
	$(".plus").click(function() {
		var $this = $(this),
		    $quantity = $this.parent().parent().find('.quantity'),
		    $stock = $quantity.parent().parent().find('.stock-num'),
	            quantity = parseInt($quantity.text(), 10)
		    stock = parseInt($stock.text(), 10);
		quantity += 1;
		$this.parent().find('.minus').removeAttr('disabled');
		if (quantity >= stock) {
			quantity = stock;
			$this.attr('disabled','');
		}
		$quantity.text(quantity);
	});

	$(".minus").click(function() {
		var $this = $(this),
		    $quantity = $this.parent().parent().find('.quantity'),
	            quantity = parseInt($quantity.text(), 10);
		quantity -= 1;
		$this.parent().find('.plus').removeAttr('disabled');
		if (quantity <= 0) {
			quantity = 0;
			$this.attr('disabled','');
		}
		$quantity.text(quantity);
	});
});
