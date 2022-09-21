let passwordField, passwordConfirmationField

document.addEventListener('turbolinks:load', function() {
  passwordField = document.querySelector('.password')
  passwordConfirmationField = document.querySelector('.password-confirmation')

  spanPasswordsMatch = document.getElementById('passwords-match')
  spanPasswordsNotMatch = document.getElementById('passwords-not-match')

  if (passwordField && passwordConfirmationField) {
    passwordField.addEventListener('input', onHandleInput)
    passwordConfirmationField.addEventListener('input', onHandleInput)
  }
})

function onHandleInput() {
  if (!passwordConfirmationFilled()) {
    spanPasswordsMatch.classList.add('d-none')
    spanPasswordsNotMatch.classList.add('d-none')
    return
  }

  if (passwordsMatch()) {
    spanPasswordsMatch.classList.remove('d-none')
    spanPasswordsNotMatch.classList.add('d-none')
  } else {
    spanPasswordsMatch.classList.add('d-none')
    spanPasswordsNotMatch.classList.remove('d-none')
  }
}

function passwordsMatch() {
  return passwordField.value === passwordConfirmationField.value
}

function passwordConfirmationFilled() {
  return passwordConfirmationField.value !== ''
}
