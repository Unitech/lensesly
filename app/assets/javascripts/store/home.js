$().ready(function() {
    $('.slider-trends .univers').each(function() {
	var self = $(this);

	$('#mask', $(this)).show(function() {

	    var btn_height = $('#access-btn').height();
	    var btn_ln_height = $('#access-btn').css('line-height');
	    
	    self.hover(function(e) {
		e.preventDefault();
		$('#mask', $(this)).animate({'height':'358'}, 100);
		$('#access-btn', $(this)).animate({'height':'115', 'line-height': '8.5'}, 100);
	    }, function(e) {
		e.preventDefault();
		$('#mask', $(this)).animate({'height':'260'}, 100);
		$('#access-btn', $(this)).animate({'height':btn_height, 'line-height' : btn_ln_height}, 100);
	    });
	    
	});
	//
    });
    
    // $('.mid-block').each(function() {
    // 	$(this).hover(function(e) {
    // 	    e.preventDefault();
    // 	    $('#mask', $(this)).animate({'height':'120'}, 100);
    // 	}, function(e) {
    // 	    e.preventDefault();
    // 	    $('#mask', $(this)).animate({'height':'100'}, 100);
    // 	});
    // });

    $('.new_newsletter').each(function() {
	$(this).submit(function(e) {
	    e.preventDefault();
	    var self = $(this);
	    var dt = $(this).find('#newsletter_mail').val();
	    if (dt.length > 0) {
		$.post('/nws/post', {dt : dt}, function(res) {
		    self.html('<b>Merci !</b>');
		}, 'json');
	    }
	    else {
		self.append('Inserez votre email');
	    }
	});
    });
    
});