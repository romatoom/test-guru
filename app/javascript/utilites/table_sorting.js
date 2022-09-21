let sortDirection = 'none'
let sortColumn = 'title'
const compareValue = () => sortDirection === 'asc' ? -1 : 1
let arrows, table, thead

document.addEventListener('turbolinks:load', function() {
  arrows = document.querySelectorAll('.sort-by-column > i')
  table = document.querySelector('.table')
  thead = table.querySelector('thead')

  const controls = document.querySelectorAll('.sort-by-column')

  for (let i = 0; i < controls.length; i++) {
    controls[i].addEventListener('click', sortRowsByColumn)
  }
})

function sortRowsByColumn() {
  clearAllArrows()

  if (sortColumn === this.dataset.sortColumn) {
    toggleSortDirection()
  } else {
    sortDirection = 'asc'
    sortColumn = this.dataset.sortColumn
  }

  const tbody = table.querySelector('tbody')

  const tbodyRows = tbody.querySelectorAll('tr')

  const sortedRows = []
  for (let i = 0; i < tbodyRows.length; i++) {
    sortedRows.push(tbodyRows[i])
  }

  sortedRows.sort(compareRows)

  const tbodySorted = document.createElement('tbody')

  for (let i = 0; i < sortedRows.length; i++) {
    tbodySorted.appendChild(sortedRows[i])
  }

  table.replaceChild(tbodySorted, tbody)

  // Change sort direction
  const arrowUp = this.querySelector('.bi-arrow-up-short')
  const arrowDown = this.querySelector('.bi-arrow-down-short')

  if (sortDirection == 'asc') {
    arrowUp.classList.remove('d-none')
    arrowDown.classList.add('d-none')
  } else {
    arrowUp.classList.add('d-none')
    arrowDown.classList.remove('d-none')
  }
}

function compareRows(prev, next) {
  const prevTitle = prev.querySelector('td.' + sortColumn).textContent
  const nextTitle = next.querySelector('td.'+ sortColumn).textContent

  if (prevTitle < nextTitle) { return compareValue() }
  if (prevTitle > nextTitle) { return -compareValue() }
  return 0
}

function toggleSortDirection() {
  sortDirection = sortDirection === 'asc' ? 'desc' : 'asc'
}

function clearAllArrows() {
  for (let i = 0; i < arrows.length; i++) {
    arrows[i].classList.add('d-none')
  }
}
