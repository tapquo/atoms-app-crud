/**
 * atoms.app.crud - 
 * @version v1.0.0
 * @link    http://tapquo.com
 * @author   ()
 * @license 
 */
(function(){"use strict";var __hasProp={}.hasOwnProperty,__extends=function(child,parent){function ctor(){this.constructor=child}for(var key in parent)__hasProp.call(parent,key)&&(child[key]=parent[key]);return ctor.prototype=parent.prototype,child.prototype=new ctor,child.__super__=parent.prototype,child};Atoms.Entity.Contact=function(_super){function Contact(){return Contact.__super__.constructor.apply(this,arguments)}return __extends(Contact,_super),Contact.fields("id","name","description","url","when","year"),Contact}(Atoms.Class.Entity),$$(function(){var crud,oihane;return console.log(Atoms.version," || ",__.version),oihane=Atoms.Entity.Contact.create({id:"@oihi08",name:"Oihare Merino",url:"http://cdn.tapquo.com/photos/oihane.jpg",when:new Date,year:1991}),crud=new Atoms.Organism.Crud({id:"contact",entity:"Atoms.Entity.Contact",fields:["name","description","url","year"],required:["name"]}),crud.show({title:"Edit "+oihane.name,entity:oihane,fields:["name","description"],required:["description"],destroy:!0})})}).call(this);