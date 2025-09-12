import "@hotwired/turbo-rails"
import "./controllers"
import "save_word_modal" 
import "bootstrap"

console.log("✅ application.js loaded")

document.addEventListener("turbo:load", () => {
  console.log("✅ turbo:load fired")
})
