last_language_tag = '';
last_language_description = '';

$(document).ready(function() {
  $('#query').focus();
  limitFieldLength('#query', 1000);
});

$(document).ready(function() {
  last_language_tag = $('#language_from').val();
  last_language_description = $('#language_from option[value="' + last_language_tag + '"]').html();
  $('#language_to option[value="' + last_language_tag + '"]').remove();
  
  $('#language_from').change(function() {
    $('#language_to').prepend('<option value="' + last_language_tag + '">' + last_language_description + '</option>');
    
    last_language_tag = this.value;
    last_language_description = $('#language_to option[value="' + last_language_tag + '"]').html();
    
    $('#query').focus();
    
    $('#language_to option[value="' + this.value + '"]').remove();
    $('#language_to').hide();
    $('#language_to').fadeIn('slow');
  });
});

function validateSearchForm() {
	
  hideAllFormAlerts("search-form");
	
  var queryInput = document.getElementById('query');
  var query = queryInput.value;
	
  if (query.length == 0) {
    showFormAlert('empty-query');
    queryInput.focus();
    return false;
  }
  else return true;

}