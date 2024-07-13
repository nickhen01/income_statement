import { Application } from "@hotwired/stimulus"

const application = Application.start()
import Notification from "stimulus-notification"
application.register("notification", Notification)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
