## Organism.Crud
Este organismo extiende de *Dialog* y sirve para crear dinamicamente una ventana de diálogo que permite realizar acciones CRUD (create, read, update and delete) a una entidad. La ventana de diálogo se cargara automáticamente con los campos de la entidad dada.

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
crud_instance = new Atoms.Organism.Crud 
  entity: "Atoms.Entity.Contact"
```

En el caso de que queramos establecer más atributos como:
  - Campos de la entidad a gestionar [Array]
  - Título del *dialog*
  - Campos obligatorios [Array]

```
crud_instance = new Atoms.Organism.Crud 
  entity : "Atoms.Entity.Contact"
  fields : ["name", "bio", "twitter"]
  title  : "CRUD Usuarios"
  required: ["name"]
```

### Methods

#### .create()
Este método muestra un *Dialog* con los campos de la entidad definida en el constructor. Los campos estaran vacios permitiendonos insertar nuevos datos y crear nuevas entidades. 

**Examples**

```
crud_instance.create
```

Si no hemos definido el title de la ventana de diálogo en el constructor del crud podriamos establecer el título:

```
crud_instance.create 
  title   : "New Contact"
```

#### .show()
Este método muestra un *Dialog* con los campos y valores de la entidad dada, permitiendonos ver,modificar y borrar la entidad. El único parámetro obligatorio de show() es la entidad que deseamos ver, modificar o borrar.
Si deseamos mostrar el boton que permita borrar la entidad debemos pasar el atributo destroy con valor true.

**Examples**

```
crud_instance.show
  title   : "Edit #{oihane.name}"
  entity  : oihane
```

Al igual que en el constructor podemos establecer más atributos como:
  - Campos de la entidad a gestionar [Array]
  - Título del *dialog*
  - Campos obligatorios [Array]

```
crud_instance.show
  title   : "Edit #{oihane.name}"
  entity  : oihane
  fields  : ["name", "description", "url", "year"]
  required: ["description"]
  destroy : true
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
