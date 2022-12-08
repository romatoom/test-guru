const MILISECOND_TO_SECOND = 1000;
const WARNING_TIME = 60
const DANGER_TIME = 10

document.addEventListener('turbolinks:load', function() {
  const countdown = document.getElementById('countdown');
  if (!countdown) return;

  let time = countdown.dataset.initialSecondsLeft;
  updateCountdown(countdown, time)

  timerId = setInterval(() => {
    if (time > 0) {
      time -= 1;
      updateCountdown(countdown, time)
    }

    if (time === 0) {
      clearInterval(timerId);
      location.reload();
    }

  }, MILISECOND_TO_SECOND);
})

function secondsToHMS(time_in_seconds) {
  return new Date(time_in_seconds * MILISECOND_TO_SECOND)
    .toISOString()
    .slice(11, 19)
}

function updateCountdown(countdown, time) {
  const time_hms = secondsToHMS(time);

  if (time >= DANGER_TIME && time < WARNING_TIME) {
    countdown.classList.add("medium-time")
  } else if (time < DANGER_TIME) {
    countdown.classList.remove("medium-time")
    countdown.classList.add("little-time")
  }

  countdown.innerText = time_hms
}




