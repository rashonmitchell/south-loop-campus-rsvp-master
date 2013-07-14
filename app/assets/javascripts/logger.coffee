require.define "logger": (exports, require, module) ->
  module.exports = class Logger
    constructor: ->
      onerror = window.onerror
      window.onerror = (message, url, line) =>
        setTimeout(@notify, 100, arguments...)
        onerror?.apply(this, arguments)

    notify: (message, url, line) ->
      $.post '/notify',
        message: message
        url: url
        line: line

