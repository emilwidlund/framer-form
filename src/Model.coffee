require '../lib/OBJLoader.js'
{Mesh} = require './Mesh.coffee'

class exports.Model
    constructor: (properties={}) ->
        switch @getExtension properties.path
            when 'obj'
                @loadObj properties.path, (model) =>
                    @setupModel model, properties

    getExtension: (path) ->
        path.split('.').pop()

    loadObj: (path, cb) ->
        @loader = new THREE.OBJLoader
        @loader.load path, (obj) ->
            cb(obj)

    setupModel: (model, properties) ->

        model.__proto__.on = (eventName, cb) ->
            model.traverse (c) ->
                if c instanceof THREE.Mesh
                    c.addEventListener eventName, cb
        
        model.__proto__.animate = Mesh.prototype.animate

        if properties.material
            @applyMaterial model, properties.material
        
        if properties.parent
            @addToRenderingInstance model, properties.parent

        @setScale model, properties.scale
        @setPosition model, [properties.x, properties.y, properties.z]
        @setRotation model, [properties.rotationX, properties.rotationY, properties.rotationZ]

        if properties.onLoad
            properties.onLoad model

    applyMaterial: (model, material) ->
        model.traverse (c) ->
            if c instanceof THREE.Mesh
                c.material = material

    addToRenderingInstance: (model, parent) ->
        if parent.scene then parent.scene.add model
        else parent.add model
    
    setScale: (model, scale) ->
        model.scale.set(
            scale || 1
            scale || 1
            scale || 1
        )
    
    setPosition: (model, position) ->
        model.position.x = position[0] || 0
        model.position.y = position[1] || 0
        model.position.z = position[2] || 0

    setRotation: (model, rotation) ->
        model.rotation.x = THREE.Math.degToRad(rotation[0]) || 0
        model.rotation.y = THREE.Math.degToRad(rotation[1]) || 0
        model.rotation.z = THREE.Math.degToRad(rotation[2]) || 0