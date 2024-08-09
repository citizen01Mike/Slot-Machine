import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slot-spinner"
export default class extends Controller {
  static targets = ["image"]
  static values = { number: Number }

  connect() {    
    spin(this.element, 3, 1, () => {
      Array.from(this.element.children).forEach((child) => { if (!child.classList.contains("hidden")) child.classList.add("hidden") })
      this.imageTarget.classList.remove("hidden")
    })
  }
}

function spin(el, count = 1, currentspin = 1, finishedCallback) {
  if (currentspin <= count) {
    currentspin += 1
    for (let i = 0; i < el.scrollHeight; i++) {
      setTimeout(() => {
        el.scrollTop = i
        if ((i + 1) == el.scrollHeight) {
          spin(el, count, currentspin, finishedCallback)
        }
      }, i);
    }
  } else {
    finishedCallback()
  }
}
