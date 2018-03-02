window.THREE = require './lib/three.min.js'
window.Form = window.THREE

{Scene} = require './src/Scene.coffee'
{Mesh} = require './src/Mesh.coffee'
{Import} = require './src/Import.coffee'

module.exports =
    Scene: Scene
    Mesh: Mesh
    Import: Import