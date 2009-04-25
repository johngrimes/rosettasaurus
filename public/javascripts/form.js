function showFormAlert(id) {	
  $('#' + id).fadeIn('slow');
}

function hideAllFormAlerts(formId) {	
  $("#" + formId + " .alert").hide();
}

function limitFieldLength(selector, limit) {
  $(selector).keydown(function(e) {
    currentValue = $(this).val();
    if (currentValue.length >= limit) {    
      $(this).val(currentValue.substring(0, limit));
      if (e.which == 8 || e.which == 46)
        return true;
      else
        return false;
    } else {
      return true;
    }
  });
  $(selector).click(function() { $(this).keydown(); });
  $(selector).change(function() { $(this).keydown(); });
}