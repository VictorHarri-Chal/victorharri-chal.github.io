import { Controller } from "@hotwired/stimulus"

// The hidden state is set in CSS, gated on the `js` class, so nothing flashes
// before this runs. All the controller does is flip the element once it scrolls
// into view.
export default class extends Controller {
  static values = { threshold: { type: Number, default: 0.1 } }

  connect() {
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
      this.element.classList.add("is-revealed")
      return
    }

    this.observer = new IntersectionObserver(this.onIntersect.bind(this), {
      threshold: this.thresholdValue,
      rootMargin: "0px 0px -50px 0px"
    })
    this.observer.observe(this.element)
  }

  disconnect() {
    this.observer?.disconnect()
  }

  onIntersect(entries) {
    if (!entries.some((entry) => entry.isIntersecting)) return

    this.element.classList.add("is-revealed")
    this.observer.disconnect()
  }
}
