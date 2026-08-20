import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["gradient"]

  connect() {
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return

    this.gradientTarget.style.transition = "background 0.3s ease-out"
    this.onMouseMove = this.onMouseMove.bind(this)
    this.element.addEventListener("mousemove", this.onMouseMove, { passive: true })
  }

  disconnect() {
    this.element.removeEventListener("mousemove", this.onMouseMove)
    if (this.frame) cancelAnimationFrame(this.frame)
  }

  onMouseMove(event) {
    this.pointer = { x: event.clientX, y: event.clientY }
    this.frame ||= requestAnimationFrame(() => {
      this.frame = null
      this.paint()
    })
  }

  // The element is measured once per frame rather than once per event, which is
  // what made this a forced synchronous layout on every pointer move.
  paint() {
    const rect = this.element.getBoundingClientRect()
    const x = ((this.pointer.x - rect.left) / rect.width) * 100
    const y = ((this.pointer.y - rect.top) / rect.height) * 100

    this.gradientTarget.style.background =
      `radial-gradient(circle at ${x}% ${y}%, rgba(255,255,255,0.08) 0%, rgba(255,255,255,0.04) 30%, transparent 70%), ` +
      "radial-gradient(circle at 50% 50%, rgba(255,255,255,0.05) 0%, transparent 70%)"
  }
}
