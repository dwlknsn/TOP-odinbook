import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dark-mode"
export default class extends Controller {
  static targets = [ "lightIcon", "darkIcon", "themeToggle" ]

  connect() {
    console.log("Dark mode controller connected")
    if (localStorage.getItem('color-theme') === 'dark' || (!('color-theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
      console.log("Current theme = dark")
      this.lightIconTarget.classList.remove('hide@sm');
    } else {
      console.log("Current theme = light")
      this.darkIconTarget.classList.remove('hide@sm');
    }
  }

  toggleTheme() {
    console.log("Toggling theme")
    this.lightIconTarget.classList.toggle('hide@sm');
    this.darkIconTarget.classList.toggle('hide@sm');

    if (localStorage.getItem('color-theme') === 'dark') {
      document.documentElement.classList.remove('dark');
      localStorage.setItem('color-theme', 'light');
    } else {
      document.documentElement.classList.add('dark');
      localStorage.setItem('color-theme', 'dark');
    }
  }
}
