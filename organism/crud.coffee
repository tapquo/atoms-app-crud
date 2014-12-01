"use strict"

class Atoms.Organism.Crud extends Atoms.Organism.Dialog

  @events: ["create", "update", "delete"]

  @default:
    id: "crud"
    children: [
      "Organism.Header":
        id: "header"
        children: [
          "Atom.Heading": 
            id: "title"
            value: "CRUD"
        ,
          "Molecule.Navigation":
            style: "right"
            children: [ "Atom.Button": icon: "close", callbacks: ["onClose"] ]
        ],
      "Organism.Section":
        id: "section"
        children: [
          "Molecule.Form":
            id: "form"
        ],
      "Organism.Footer":
        id: "footer"
        children: [
          "Molecule.Navigation":
            id: "nav"
            children: [
              "Atom.Button": 
                id: "delete"
                text: "Delete"
                callbacks: ["onDestroy"]
                style: "left"
            ,
              "Atom.Button": 
                id: "save"
                text: "Save"
                callbacks: ["onSave"]
                style: "right"
            ]

        ]
    ]

  @extends: true


  constructor: (data) ->
    super
    if data?
      @header.title.refresh value: data.title if data.title?
      if data.columns?
        @columns = data.columns
      else if data.entity?
        @entityType = data.entity
        @columns = @_parseArrayToColumnsObj data.entity.attributes
      @required = data.required if data.required?

      console.log "@columns:", @columns
      @_createFields @columns, @required? if @columns?

  _parseArrayToColumnsObj: (array) ->
    columns = {}
    columns[field] = "text" for field in array
    columns

  _createFields:(columns, required)->
    @section.form.destroyChildren()


    for field of columns
      properties =
        id         : field
        name       : field
        type       : "text"
        placeholder: field
        required   : true if field in required?
      @section.form.appendChild "Atom.Input", properties

  onClose: ->
    do @hide

  onSave: (event, atom)->

    requiredPass = true
    for child in @section.form.children
      if child.attributes.required and not child.value()
        child.el.addClass "error"
        requiredPass = false
      else
        child.el.removeClass "error"

    if requiredPass
      if @entitySelected?
        @update @entitySelected
      else
        @create @section.form.value()
      @hide()

  onDestroy: ->
    @destroy @entitySelected
    do @hide

  show: (info) ->
    super
    @section.form.clean()
    @footer.nav.delete.el.hide()

    if info?
      @header.title.refresh value: info.title if info.title?
      
      if info.entity?
        @entitySelected = info.entity
        @footer.nav.delete.el.show()
      if info.columns?
        columns = info.columns
      else if info.entity?
        columns = @_parseArrayToColumnsObj __.Entity[info.entity.className].attributes
      else
        columns = @columns

      @_createFields columns, if info.required? then info.required else @required
      @section.form["#{field}"].value info.entity["#{field}"] for field of columns if columns?
    else
      @entitySelected = null


  create: (values) ->
    entity = @entityType.create values
    @trigger "create", entity

  update: (entity) ->
    entity.updateAttributes @section.form.value()
    @trigger "update", entity

  destroy: (entity) ->
    entity.destroy()
    @trigger "destroy", entity