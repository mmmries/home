import "phoenix_html"

import socket from "./socket"
import texasjs from "texasjs"

// Texas needs access to the phoenix apps websocket
new texasjs(socket)
