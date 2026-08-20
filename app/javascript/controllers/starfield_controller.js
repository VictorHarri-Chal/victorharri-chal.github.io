import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["starfield"]

  connect() {
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return

    this.bindMouseMove()
  }

  disconnect() {
    this.unbindMouseMove()
  }

  bindMouseMove() {
    this.handleMouseMove = this.handleMouseMove.bind(this)
    document.addEventListener('mousemove', this.handleMouseMove)
  }

  unbindMouseMove() {
    document.removeEventListener('mousemove', this.handleMouseMove)
  }

  handleMouseMove(event) {
    const { clientX, clientY } = event
    const { innerWidth, innerHeight } = window

    // Calculer la position relative de la souris (0 à 1)
    const x = (clientX / innerWidth - 0.5) * 2 // -1 à 1
    const y = (clientY / innerHeight - 0.5) * 2 // -1 à 1

    // Appliquer un déplacement plus lent au fond étoilé
    const moveX = x * 8 // Déplacement max de 8px (plus lent)
    const moveY = y * 8 // Déplacement max de 8px (plus lent)

    this.starfieldTarget.style.transform = `translate(${moveX}px, ${moveY}px)`
  }
}
