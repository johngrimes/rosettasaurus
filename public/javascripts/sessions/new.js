$(document).ready(function() {
  $('#login').focus();
});

function validateForm() {
	
  hideAllFormAlerts("login-form");
	
  var loginInput = document.getElementById('login');
  var passwordInput = document.getElementById('password');
  
  var login = loginInput.value;
  var password = passwordInput.value;
  
  if (login.length == 0) {
    showFormAlert('empty-login');
    loginInput.focus();
    return false;
  } 
  else if (password.length == 0) {
    showFormAlert('empty-password');
    passwordInput.focus();
    return false;
  } 
  else return true;

}