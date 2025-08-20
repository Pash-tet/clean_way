import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]
  connect() {
    console.log("yay")
  }

  switch() {
    this.contentTarget.classList.toggle("hidden")
  }
}
