import { Controller } from "@hotwired/stimulus"

// import { ui } from "beercss"

export default class extends Controller {
  static targets = ["icon"]
  connect() {
    console.log("yay")
  }

  switch() {
    // this.iconTarget.innerHTML = `${ui("mode") === "dark" ? "dark" : "light"}_mode`
    //
    // ui("mode", ui("mode") === "dark" ? "light" : "dark")
  }
}
