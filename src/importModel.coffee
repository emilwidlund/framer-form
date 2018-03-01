require '../lib/OBJLoader.js'



exports.importModel = (source, cb) ->
    loader = new THREE.OBJLoader()
    loader.load source, (obj) ->
        cb obj