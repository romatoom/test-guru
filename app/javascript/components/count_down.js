const SECONDS_IN_HOUR = 3600;
const SECONDS_IN_MINUTE = 60;
const WARNING_TIME = 60
const DANGER_TIME = 10

document.addEventListener('turbolinks:load', function() {
  const countdown = document.getElementById('countdown');
  if (!countdown) return;

  hoursEl = countdown.querySelector(".hours");
  minutesEl = countdown.querySelector(".minutes");
  secondsEl = countdown.querySelector(".seconds");

  let time = countdown.dataset.initialSecondsLeft;
  updateCountdown(countdown, time, hoursEl, minutesEl, secondsEl);

  timerId = setInterval(() => {
    if (time > 0) {
      time -= 1;
    } else {
      // document.getElementById("btn-next").click();
      clearInterval(timerId);

      location.reload();
    }

    if (time < 0) time = 0;

    updateCountdown(countdown, time, hoursEl, minutesEl, secondsEl)
  }, 1000);
})

function secondsToHMS(time_in_seconds) {
  const h = Math.floor(time_in_seconds / SECONDS_IN_HOUR);
  const m = Math.floor(time_in_seconds % SECONDS_IN_HOUR / SECONDS_IN_MINUTE);
  const s = Math.floor(time_in_seconds % SECONDS_IN_HOUR % SECONDS_IN_MINUTE);

  return [h, m, s].map((el) => formatter(el));
}

function formatter(value) {
  if (value < 10) return `0${value}`
  return `${value}`
}

function updateCountdown(countdown, time, hoursEl, minutesEl, secondsEl) {
  console.log("Update");
  const [h, m, s] = secondsToHMS(time);

  if (time >= DANGER_TIME && time < WARNING_TIME) {
    countdown.classList.add("medium-time")
  } else if (time < DANGER_TIME) {
    countdown.classList.remove("medium-time")
    countdown.classList.add("little-time")
  }

  hoursEl.innerText = h
  minutesEl.innerText = m
  secondsEl.innerText = s
}




