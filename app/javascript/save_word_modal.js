document.addEventListener("turbo:load", () => {
  console.log("✅ save_word_modal loaded")

  const modalEl = document.getElementById("saveWordModal")
  if (!modalEl) return

  const bsModal = new bootstrap.Modal(modalEl)
  const termInput = document.getElementById("modal_word_term")
  const meaningInput = document.getElementById("modal_word_meaning")

  document.querySelectorAll(".open-modal-btn").forEach(btn => {
    btn.addEventListener("click", () => {
      termInput.value = btn.dataset.term
      meaningInput.value = btn.dataset.meaning
      bsModal.show()
    })
  })
})
