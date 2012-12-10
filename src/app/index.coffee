derby = require 'derby'
{get, view, ready} = derby.createApp module
derby.use(require '../../ui')


## ROUTES ##


# Derby routes can be rendered on the client and the server
get '*', (page, model) ->

  # Subscribes the model to any updates on this room's object. Calls back
  # with a scoped model equivalent to:
  #   room = model.at "rooms.#{roomName}"
  model.subscribe 'items', (err, items) ->
    model.set '_ids', (item for item of items.get())
    model.refList '_items', 'items', '_ids'

    # Render will use the model data as well as an optional context object
    page.render()


## CONTROLLER FUNCTIONS ##

ready (model) ->

  @add = (e, el) ->
    c = e.keyCode || e.charCode
    if c == 13
      e.stopPropagation()
      e.preventDefault()

      id = model.id()
      model.set "items.#{id}",
        text: el.value
        created_at: new Date(),
        (err) -> 
          console.log 'added: error = '+err
          model.push '_ids', id

      el.value = ''
      false
    else
      true