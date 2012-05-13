$().ready(function() {
    $('.slider-trends .univers').each(function() {
	$(this).hover(function(e) {
	    e.preventDefault();
	    $('#mask', $(this)).animate({'height':'358'}, 100);
	}, function(e) {
	    e.preventDefault();
	    $('#mask', $(this)).animate({'height':'160'}, 100);
	});
    });
    
    $('.mid-block').each(function() {
	$(this).hover(function(e) {
	    e.preventDefault();
	    $('#mask', $(this)).animate({'height':'120'}, 100);
	}, function(e) {
	    e.preventDefault();
	    $('#mask', $(this)).animate({'height':'100'}, 100);
	});
    });
});