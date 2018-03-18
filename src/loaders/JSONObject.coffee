class exports.JSONObject
    constructor: (properties, cb) ->

        @readJSON properties.path, (json) => 
            metadata = JSON.parse(json).metadata

            if metadata.type == 'Object' then @loadObject properties, cb
            else @loadGeometry properties, cb


    loadObject: (properties, cb) ->
        @modelLoader = new THREE.ObjectLoader
        @modelLoader.load properties.path, (model) =>
            cb model
        , null, (e) -> console.log e
    
    loadGeometry: (properties, cb) ->
        @modelLoader = new THREE.JSONLoader
        @modelLoader.load properties.path, (geometry, materials) =>
            material = materials[0]
            model = new THREE.Mesh geometry, material
            model.animations = geometry.animations
            
            cb model
        , null, (e) -> console.log e

    readJSON: (path, cb) ->
        rawFile = new XMLHttpRequest
        rawFile.overrideMimeType 'application/json'
        rawFile.open 'GET', path, true
        rawFile.onreadystatechange = () ->
            if rawFile.readyState == 4 && rawFile.status == 200
                cb rawFile.responseText
        rawFile.send null