let tableEditable

document.addEventListener('turbolinks:load', function() {
  tableEditable = document.getElementById('table-editable')

  if (!tableEditable) return

  inlineEditsEnabled = []

  editLinks = document.querySelectorAll('.inline-edit-title-link')

  for (i = 0; i < editLinks.length; i++) {
    inlineEditsEnabled[i] = false
    editLinks[i].addEventListener('click', onClickHandler)
  }

  const errorBlock = document.getElementById('error_explanation')

  if (errorBlock) {
    const resourceId = errorBlock.dataset.resourceId
    onInlineEditHandler(resourceId)
  }
})

function onClickHandler(event) {
  event.preventDefault()
  onInlineEditHandler(this.dataset.testId)
}

function onInlineEditHandler(testId) {
  spanTitle = document.querySelector('.test-title[data-test-id="' + testId + '"]')
  inlineEditTitle = document.querySelector('.inline-edit-title[data-test-id="' + testId + '"]')

  btnEditCancel = document.querySelector('.inline-edit-title-link[data-test-id="' + testId + '"]')

  inlineEditsEnabled[testId] = !inlineEditsEnabled[testId]

  if (inlineEditsEnabled[testId]) {
    spanTitle.classList.add('d-none')
    inlineEditTitle.classList.remove('d-none')

    btnEditCancel.textContent = tableEditable.dataset.cancelText
  } else {
    spanTitle.classList.remove('d-none')
    inlineEditTitle.classList.add('d-none')

    btnEditCancel.textContent = tableEditable.dataset.editText
  }
}

