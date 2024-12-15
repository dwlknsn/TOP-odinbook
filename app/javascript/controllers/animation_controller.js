import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="animation"
export default class extends Controller {
  static targets = [ "refreshIcon", "commentsSection" ];

  connect() {
    console.log("AnimationController connected");
  }

  spin() {
    this.refreshIconTarget.style.animation = "spin 0.5s linear"
    this.commentsSectionTarget.style.animation = "slide-in-left .5s cubic-bezier(.25, 0, .3, 1)"

    this.cleanup()
  }

  cleanup() {
    setTimeout(() => {
      this.refreshIconTarget.style = null;
      this.commentsSectionTarget.style = null;
    }, 500)
  }
}
