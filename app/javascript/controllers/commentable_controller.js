import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="commentable"
export default class extends Controller {
  static targets = [ "formContainer", "replyButton", "input" ]

  connect() {}

  toggle(event) {
    event.preventDefault()
    this.formContainerTarget.classList.toggle("hide@sm")
    this.replyButtonTarget.toggleAttribute("disabled")
    this.inputTarget.value = ""
  }
}
