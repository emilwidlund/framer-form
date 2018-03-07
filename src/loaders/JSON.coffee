class exports.JSON
    constructor: (properties, cb) ->
        @modelLoader = new THREE.JSONLoader
        @modelLoader.load properties.path, (geometry, materials) =>
            material = materials[0]
            model = new THREE.Mesh geometry, material
            model.animations = geometry.animations
            cb model
        , null, (e) -> console.log e