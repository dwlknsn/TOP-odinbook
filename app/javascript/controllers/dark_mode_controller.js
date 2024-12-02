import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dark-mode"
export default class extends Controller {
  static targets = [ "lightIcon", "darkIcon", "themeToggle" ]

  connect() {
    this.#setInitialTheme()
  }

  toggleTheme() {
    if (localStorage.getItem('color-theme') === 'dark') {
      this.#setThemeToLight()
    } else {
      this.#setThemeToDark()
    }
  }

  #setInitialTheme() {
    if (localStorage.getItem('color-theme') === 'dark') {
      this.#setThemeToDark()
    } else if (!localStorage.getItem('color-theme') && window.matchMedia('(prefers-color-scheme: dark)').matches) {
      this.#setThemeToDark()
    } else {
      this.#setThemeToLight()
    }
  }

  #setThemeToLight() {
    this.lightIconTarget.classList.add('hide@sm');
    this.darkIconTarget.classList.remove('hide@sm');
    document.body.classList.remove('dark');
    localStorage.setItem('color-theme', 'light');
  }

  #setThemeToDark() {
    this.lightIconTarget.classList.remove('hide@sm');
    this.darkIconTarget.classList.add('hide@sm');
    document.body.classList.add('dark');
    localStorage.setItem('color-theme', 'dark');

  }
}
