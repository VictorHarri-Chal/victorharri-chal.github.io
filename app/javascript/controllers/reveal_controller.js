import { Controller } from "@hotwired/stimulus"

// data-controller="reveal" data-reveal-class="opacity-100 translate-y-0"
export default class extends Controller {
  static values = { threshold: { type: Number, default: 0.1 }, class: String }

  connect() {
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return

    this.element.classList.add("opacity-0", "translate-y-8", "transition-all", "duration-1000", "ease-out")
    this.observer = new IntersectionObserver(this.onIntersect.bind(this), {
      root: null,
      threshold: this.thresholdValue,
      rootMargin: "0px 0px -50px 0px"
    })
    this.observer.observe(this.element)
  }

  disconnect() {
    this.observer && this.observer.disconnect()
  }

  onIntersect(entries) {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        this.element.classList.remove("opacity-0", "translate-y-8")
        const extra = this.hasClassValue ? this.classValue.split(" ") : []
        this.element.classList.add("opacity-100", "translate-y-0", ...extra)
        this.observer.disconnect()
      }
    })
  }
}
