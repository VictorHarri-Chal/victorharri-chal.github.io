import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["starfield"]

  connect() {
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return

    this.onMouseMove = this.onMouseMove.bind(this)
    document.addEventListener("mousemove", this.onMouseMove, { passive: true })
  }

  disconnect() {
    document.removeEventListener("mousemove", this.onMouseMove)
    if (this.frame) cancelAnimationFrame(this.frame)
  }

  // Pointer events fire far more often than the screen refreshes, so the write
  // is coalesced down to one per frame.
  onMouseMove(event) {
    this.pointer = { x: event.clientX, y: event.clientY }
    this.frame ||= requestAnimationFrame(() => {
      this.frame = null
      this.move()
    })
  }

  move() {
    const x = (this.pointer.x / window.innerWidth - 0.5) * 2
    const y = (this.pointer.y / window.innerHeight - 0.5) * 2

    this.starfieldTarget.style.transform = `translate(${x * 8}px, ${y * 8}px)`
  }
}
