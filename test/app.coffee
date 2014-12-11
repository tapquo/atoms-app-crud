"use strict"

$$ ->
  console.log Atoms.version, " || ", __.version

  oihane = Atoms.Entity.Contact.create
    id    : "@oihi08"
    name  : "Oihare Merino"
    url   : "http://cdn.tapquo.com/photos/oihane.jpg"
    when  : new Date()
    year  : 1991

  # @Initialize
  crud = new Atoms.Organism.Crud
    id      : "contact"
    entity  : "Atoms.Entity.Contact"
    fields  : ["name", "description", "url", "year"]
    required: ["name"]

  # @Create new entity
  # crud.create
  #   title   : "New Contact"

  # @Update oihane entity
  crud.show
    title   : "Edit #{oihane.name}"
    entity  : oihane
    fields  : ["name", "description"]
    required: ["description"]
    destroy : true
