$().ready(function() {
    $('.mini-admin').each(function() {
	var prod_id = $(this).attr('data-id');
	var self = $(this);
	var prod = $(this).parent();

	$(this).find('#delete-db').click(function() {
	    $.post('/adm/ajx/dl', {id : prod_id}, function(res) {
		prod.fadeOut(function() {
		    $(this).remove();
		    return ;
		});
	    }, 'json');
	});
	
	$(this).find('#change-universe .ajaxround').each(function() {	    
	    $(this).click(function() {
		var self = $(this);

		$.post('/adm/ajx/switch', {prod_id : prod_id, tax_id : $(this).attr('data-id')},
		       function(res) {
			   if (res.action == 'delete') {
			       self.removeClass('setted');
			       self.addClass('notsetted');
			   }
			   else {
			       self.removeClass('notsetted');
			       self.addClass('setted');
			   }
			   return ;
		       }, 'json');
	    });
	});	
    });
    
    if ($('.mini-admin').length > 0) {
	var str = $('<input type="button" value="Desactivate Light Admin" id="activate-admin"/>');
	str.click(function() {
	    $('.mini-admin').each(function() {
		$(this).fadeOut();
	    });
	});
	$('#nav-bar').append(str);
    }
});