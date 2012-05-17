
function new_item_added_to_cart(name) {
    _gaq.push(['_trackEvent', 'Panier', 'Ajout', name]);
}

$().ready(function() {
    $('.slider-trends a').each(function() {
	//console.log($(this));
	var self = $(this);
	$(this).find('.univers').click(function() {
	    _gaq.push(['_trackEvent', 'Univers', 'Click', self.attr('title')]);
	});
    });
});