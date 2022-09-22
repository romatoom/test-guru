document.addEventListener('turbolinks:load', function() {
  const progressBar = document.querySelector('.tg-progress-bar')
  if (!progressBar) return;

  const position = progressBar.dataset.position
  const count = progressBar.dataset.count

  const percent = position && count ? (position - 1) / count * 100 : 100

  const progressEl = progressBar.querySelector('.tg-progress')
  progressEl.style.width = percent + '%'
})
