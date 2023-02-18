import "phoenix_html"

// If you don't plan to use LV or websockets you can delete all of the code below.
import {Socket} from "phoenix"
import topbar from "topbar"
import {LiveSocket} from "phoenix_live_view"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})
let topBarScheduled = undefined

topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(500)
window.addEventListener("phx:page-loading-stop", _info => topbar.hide()

liveSocket.connect()

// Expose liveSocket on window for console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // active for current browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket
