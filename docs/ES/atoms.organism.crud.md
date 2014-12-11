## Organism.Crud
Este elemento sirve para crear un CRUD (create, read, update and delete) de una entidad dinámicamente sobre ventanas flotantes o mensajes de dialogo con los campos que tiene la entidad. Es un elemento contenedor padre que contendra los campos de texto de la entidad.

### Attributes

```
id        : String [OPTIONAL]
style     : String [OPTIONAL]
title     : String [OPTIONAL]
entity    : String|EntityObject [REQUIRED]
fields    : [String] [OPTIONAL]
required  : [String] [OPTIONAL]
destroy   : Boolean [OPTIONAL]
```


### Constructor

#### new Atoms.Organism.Crud()

El constructor debe ser inicializado al menos con el atributo `entity`, en este atributo estableceremos el namespace de la *entity* que queremos gestionar. De esta manera este organismo será capaz de establecer la estructura base del formulario:

**Examples**

```
crud_instance = new Atoms.Organism.Crud({entity: "Atoms.Entity.Contact"})
```

En el caso de que queramos establecer más atributos como:
  - Título del *dialog*
  - Campos de la entidad a gestionar
  - Campos obligatorios

```
crud_instance = new Atoms.Organism.Crud 
  entity : "Atoms.Entity.Contact"
  fields : ["name", "bio", "twitter"]
  title  : "CRUD Usuarios"
  required: ["name"]
```

### Methods

#### .show()
Este método muestra un *Dialog* con los campos de la entidad. Si no se pasa una *entity* al metodo show(), mostrara un Dialog con los campos de la entidad definida en el constructor permitiendonos crear nuevas entidades de ese tipo. 

En caso contrario mostrara los campos y datos de la entidad pasada por parametro y nos permitira modificarla o borrarla.

**Example**

```
crud_instance.show();
```

#### .show(parameters)

Es posible no mostrar todos los campos de la entidad indicando en el parámetro *columns* cuales se quieren mostrar, el cual recibe un objeto campo: tipo.

Es posible definir campos como *required*(obligatorios) usando el parámetro *required* que recibe un array de los campos.

Podemos establecer el titulo de la ventana del CRUD pasando por parametro *title*.

**Example**

```
    crud_instance.show 
      entity: atom.entity
      title : "Edit contact"
      required: ["name"]
      columns:
        name        : "string"
        description : "string"
```

#### .hide()
Este método permite ocultar el CRUD.

**Example**

```
crud_instance.hide();
```


### Events

En este tipo de elementos no tiene ningún sentido el sistema de eventos *Bubble* ya que no tiene ningun elemento padre, por lo tanto la suscripción a los eventos se realizará de la siguiente manera:

```
crud_instance.bind(NAME_OF_EVENT, function(event) {
  /* Your code */
});
```
Los eventos disponibles son: *create*, *update* y *destroy*.

**Example**

```
  crud_instance.bind "update", (entity) ->
    console.log "entity updated:", entity

  crud_instance.bind "create", (entity) ->
    console.log "entity created:", entity
  
  crud_instance.bind "destroy", (entity) ->
    console.log "entity destroyed:", entity
```
