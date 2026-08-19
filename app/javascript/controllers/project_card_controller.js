import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { projectSlug: String }

  click(event) {
    // Don't navigate if clicking on a link (like GitHub)
    if (event.target.closest('a')) return
    if (!this.projectSlugValue) return

    // Use relative path for GitHub Pages compatibility
    const basePath = window.location.pathname.includes('/projects/') ? '../' : './'
    window.location.href = `${basePath}projects/${this.projectSlugValue}.html`
  }
}
