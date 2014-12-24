"use strict"

class Atoms.Organism.Crud extends Atoms.Organism.Dialog

  @extends: true

  @events : ["create", "update", "delete"]

  @default:
    children: [
      "Organism.Header":
        id      : "header"
        children: [
          "Atom.Heading": id: "title"
        ,
          "Molecule.Navigation":
            style   : "right"
            children: [ "Atom.Button": icon: "close", callbacks: ["onClose"] ]
        ],
      "Organism.Section":
        id      : "section"
        children: [ "Molecule.Form": id: "form" ],
      "Organism.Footer":
        id      : "footer"
        children: [
          "Molecule.Navigation":
            id: "nav"
            children: [
              "Atom.Button":
                id        : "delete"
                style     : "left"
                text      : "Delete"
                callbacks : ["onDestroy"]
            ,
              "Atom.Button":
                id        : "save"
                style     : "right default"
                text      : "Save"
                callbacks : ["onSave"]
            ]
        ]
    ]

  constructor: ->
    super
    @attributes.fields = @attributes.fields or @entity.toClassObject()?.attributes
    @entityConstructor = @entity.toClassObject()
    delete @entity

  # -- Public Events -----------------------------------------------------------
  create: (attributes = {}) ->
    attributes.destroy = false
    delete attributes.entity
    @show attributes

  show: (attributes = {}) ->
    super
    @header.title.el.html attributes.title or @attributes.title
    @entity = attributes.entity
    fields = @attributes.fields
    if attributes.fields
      fields = attributes.fields or @attributes.fields or @entity?.constructor.attributes
    @__createFields fields, attributes.required
    @section.form.value @entity if @entity
    @footer.nav.delete.el[if attributes.destroy then "show" else "hide"]()

  # -- Children Bubble Events --------------------------------------------------
  onSave: (event, atom)->
    valid = true
    values = @section.form.value()
    for key, value of values when key in @attributes.required and not value
      valid = false
      break
    if valid
      if @entity
        method = "update"
        @entity.updateAttributes values
      else
        method = "create"
        @entity = @entityConstructor.create values
      @trigger method, @entity
      do @hide

  onDestroy: ->
    @entity.destroy()
    @trigger "destroy", @entity
    do @hide

  onClose: ->
    do @hide

  # -- Private methods ---------------------------------------------------------
  __createFields:(fields, required = @attributes.required or [])->
    @section.form.destroyChildren()
    for field in fields
      @section.form.appendChild "Atom.Input",
        id         : field
        name       : field
        type       : @__type field
        placeholder: field
        required   : true if field in required

  __type: (field) ->
    type = "text"
    value = typeof @entity?[field]
    if value is "number" then type = "number"
    if value is "boolean" then type = "checkbox"
    type
