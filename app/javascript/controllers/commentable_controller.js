import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="commentable"
export default class extends Controller {
  static targets = [ "formContainer", "replyButton", "form" ]

  connect() {}

  toggle() {
    this.formContainerTarget.classList.toggle("hide@sm")
    this.replyButtonTarget.toggleAttribute("disabled")
  }

  resetForm() {
    this.formTarget.reset()
    this.toggle()
  }

  discardComment(event) {
    console.log("discard comment")
    event.preventDefault()
    this.resetForm()
  }
}
