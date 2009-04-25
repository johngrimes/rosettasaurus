last_language_id = '';
last_language_description = '';

$(document).ready(function() {
  if ($('#translation_from_sentence').val() == '') {
    $('#translation_from_sentence').focus();
  } else {
    $('#translation_to_sentence').focus();
  }
  limitFieldLength('#translation_from_sentence', 1000);
  limitFieldLength('#translation_to_sentence', 1000);
});

$(document).ready(function() {
  last_language_id = $('#translation_from_language_id').val();
  last_language_description = $('#translation_from_language_id option[value="' + last_language_id + '"]').html();
  $('#translation_to_language_id option[value="' + last_language_id + '"]').remove();
  
  $('#translation_from_language_id').change(function() {
    $('#translation_to_language_id').prepend('<option value="' + last_language_id + '">' + last_language_description + '</option>');
    
    last_language_id = this.value;
    last_language_description = $('#translation_to_language_id option[value="' + last_language_id + '"]').html();
    
    if ($('#translation_from_sentence').val() == '') {
      $('#translation_from_sentence').focus();
    } else {
      $('#translation_to_sentence').focus();
    }
    
    $('#translation_to_language_id option[value="' + this.value + '"]').remove();
    $('#translation_to_language_id').hide();
    $('#translation_to_language_id').fadeIn('slow');
  });
});

function validateForm() {
	
  hideAllFormAlerts("translation-form");
	
  var fromSentenceInput = document.getElementById('translation_from_sentence');
  var toSentenceInput = document.getElementById('translation_to_sentence');
  var commentInput = document.getElementById('comment');
  
  var fromSentence = fromSentenceInput.value;
  var toSentence = toSentenceInput.value;
  if (commentInput)
    var comment = commentInput.value;
	
  if (fromSentence.length == 0) {
    showFormAlert('empty-from-sentence');
    fromSentenceInput.focus();
    return false;
  } 
  else if (toSentence.length == 0) {
    showFormAlert('empty-to-sentence');
    toSentenceInput.focus();
    return false;
  } 
  else if (commentInput && comment.length == 0) {
    showFormAlert('empty-comment');
    commentInput.focus();
    return false;
  } 
  else return true;

}