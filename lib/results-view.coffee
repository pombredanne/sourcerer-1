{$$, SelectListView} = require 'atom-space-pen-views'

class ResultView extends SelectListView
  # items is a list of string code snippets
  initialize: (@editor, items) ->
    super

    console.log "Provided to view:"
    console.log items
    @addClass('overlay from-top')
    @setItems(items)
    @panel ?= atom.workspace.addModalPanel(item: this)
    @panel.show()
    @focusFilterEditor()

  viewForItem: (item) ->
    $$ ->
      @li class: 'two-lines', =>
        @div "StackOverflow Snippet", class: 'primary-line'
        @div class: 'secondary-line', =>
          for section in item.sections
            if section.type == "code"
              @pre section.body
            else if section.type == "text"
              @p section.body

  confirmed: (item) ->
    console.log("CONFIRMED")
    @cancel()
    @editor.insertText JSON.stringify(item, 2)

  cancelled: ->
    console.log("CANCELLED")
    @hide()

  hide: ->
    @panel?.hide()

module.exports = ResultView
