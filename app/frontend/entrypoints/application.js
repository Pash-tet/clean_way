import {Application} from "@hotwired/stimulus"
import "@hotwired/turbo-rails"
import {registerControllers} from "stimulus-vite-helpers"

const application = Application.start()
const controllers = import.meta.glob("@/controllers/**/*_controller.js", {
  eager: true,
})

// Configure Stimulus development experience
// application.debug = false
// window.Stimulus = application

registerControllers(application, controllers)

// Example: Load Rails libraries in Vite.
//
// import * as Turbo from "@hotwired/turbo"
// Turbo.start()
//
// import ActiveStorage from '@rails/activestorage'
// ActiveStorage.start()
//
// // Import all channels.
// const channels = import.meta.globEager('./**/*_channel.js')
