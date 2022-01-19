import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
require ("jquery")
require("./validate_image.js")
import "bootstrap"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import I18n from 'i18n-js'
window.I18n = I18n
