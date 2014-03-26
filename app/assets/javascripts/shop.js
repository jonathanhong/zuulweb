/* ZuulWeb 2.0 Shop Index shop.js JavaScript Document */

$(function() {
	updateBalance();
	
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
		updateBalance();
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
		updateBalance();
	});
});

function updateBalance() {
	var $buy = $('#buy'),
	    $total = $('#total'),
	    $balance = $('#balance'),
	    total = 0.0,
	    balance = parseFloat($('select option:selected').data('balance'));
	$('#items tbody tr').each(function () {
		var $this = $(this),
		    $quantity = $this.find('.quantity'),
		    $price = $this.find('.price-num'),
	            quantity = parseInt($quantity.text(), 10)
		    price = parseFloat($price.text());
		total += quantity * price;
	});
	balance -= total;
	$total.text(total);
	$balance.text(balance);
	if (total > 0.0) {
		$buy.removeAttr('disabled');
	} else {
		$buy.attr('disabled', 'disabled');
	}
}
