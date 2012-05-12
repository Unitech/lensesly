$().ready(function() {
    $('.slider-trends .univers').each(function() {
	$(this).hover(function(e) {
	    e.preventDefault();
	    $('#mask', $(this)).animate({'height':'352'}, 100);
	}, function(e) {
	    e.preventDefault();
	    $('#mask', $(this)).animate({'height':'160'}, 100);
	});
    });
});