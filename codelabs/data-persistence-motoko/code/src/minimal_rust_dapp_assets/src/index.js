import { rust_hello } from "../../declarations/rust_hello";

document.addEventListener('DOMContentLoaded', async function () {
  const counter = await rust_hello.get();
  document.getElementById("counter").innerText = "Counter: " + counter;
})

document.getElementById("clickMeBtn").addEventListener("click", async () => {
  const counter = await rust_hello.increment();
  document.getElementById("counter").innerText = "Counter: " + counter;
});
