String? validateMessage(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter message';
  }
  return null;
}

String? validateLocation(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter Location';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Field can\'t be empty';
  }
  return null;
}

String? namevalidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Field cannot be empty';
  } else if (value.length < 5) {
    return 'Please Enter >5';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Field can\'t be empty';
  }
  return null;
}

String? validateNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Field can\'t be empty';
  } else if (value.length != 10) {
    return 'Enter valid number';
  }
  return null;
}
