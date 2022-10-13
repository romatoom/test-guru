document.addEventListener('turbolinks:load', function() {
  const badgePreview = document.getElementById('tg-badge-preview');

  const inputBadgeTitle = document.getElementById('badge_title');
  const inputBadgeDescription = document.getElementById('badge_description');
  const inputBadgeUrl = document.getElementById('badge_url');

  if (!badgePreview) {
    return;
  }

  const badgeTitle = badgePreview.querySelector('.tg-badge-title');
  const badgeDescription = badgePreview.querySelector('.tg-badge-description');
  const badgeImg = badgePreview.querySelector('.tg-badge-img>img');

  inputBadgeTitle.addEventListener('input', () => {
    badgeTitle.innerHTML = inputBadgeTitle.value;
  })

  inputBadgeDescription.addEventListener('input', () => {
    badgeDescription.innerHTML = inputBadgeDescription.value;
  })

  inputBadgeUrl.addEventListener('change', () => {
    const fileName = inputBadgeUrl.value;
    console.log(fileName)
    badgeImg.src = "/images/badges/" + fileName;
  })
})
