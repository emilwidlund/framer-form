require '../lib/OBJLoader.js'
require '../lib/MTLLoader.js'

class exports.OBJ
    constructor: (properties, cb) ->
        path = properties.path
        @dirPath = path.substring 0, path.indexOf(path.split('/').pop())
        @modelPath = path.split('/').pop()
        @materialPath = @modelPath.replace '.obj', '.mtl'
        
        @materialLoader = new THREE.MTLLoader
        @modelLoader = new THREE.OBJLoader

        @materialLoader.setTexturePath @dirPath
        @materialLoader.setPath @dirPath
        @materialLoader.crossOrigin = ''
        @materialLoader.load @materialPath, (materials) =>
            materials.preload()

            for m in materials.materials
                m.map.magFilter = THREE.NearestFilter
                m.map.minFilter = THREE.LinearFilter

            @modelLoader.setMaterials materials
            @modelLoader.setPath @dirPath
            @modelLoader.load @modelPath, (model) =>
                cb model