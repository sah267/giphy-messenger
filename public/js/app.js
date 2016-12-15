/**
 * @function to validate phone input is in correct format for twilio API
 * @returns {boolean} if valid return true, else add error styling and return false
 */
var validate = function() {

	// start fresh with no error styles
	$('#phone').parent().removeClass('has-error');
	$('#phone').siblings('.error').hide();

	// create regex expression to test against
	var phonePattern = new RegExp(/\+\d{11}/g); // + followed by exactly 11 digits

	// test phone input against regex pattern
	if (!phonePattern.test($('#phone').val())) {

		// if failed, add error styles and return false
		$('#phone').parent().addClass('has-error');
		$('#phone').siblings('.error').show();

		return false;
	} else { // else return true
		return true;
	}
};