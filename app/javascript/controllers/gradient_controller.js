import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["gradient"]

  connect() {
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return

    this.bindMouseMove()
    // Ajouter une transition CSS pour créer l'effet de traînée
    this.gradientTarget.style.transition = "background 0.3s ease-out"
  }

  disconnect() {
    this.unbindMouseMove()
  }

  bindMouseMove() {
    this.handleMouseMove = this.handleMouseMove.bind(this)
    this.element.addEventListener('mousemove', this.handleMouseMove)
  }

  unbindMouseMove() {
    this.element.removeEventListener('mousemove', this.handleMouseMove)
  }

  handleMouseMove(event) {
    const rect = this.element.getBoundingClientRect()
    const x = event.clientX - rect.left
    const y = event.clientY - rect.top

    // Calculer la position relative (0 à 1)
    const xPercent = (x / rect.width) * 100
    const yPercent = (y / rect.height) * 100

    // Combiner le gradient radial de base avec l'effet de souris
    this.gradientTarget.style.background = `radial-gradient(circle at ${xPercent}% ${yPercent}%, rgba(255,255,255,0.08) 0%, rgba(255,255,255,0.04) 30%, transparent 70%), radial-gradient(circle at 50% 50%, rgba(255,255,255,0.05) 0%, transparent 70%)`
  }
}
