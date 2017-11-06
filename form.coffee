window.THREE = require './lib/three.min.js'
window.Form = window.THREE

{SceneCanvas} = require './src/SceneCanvas.coffee'
{importModel} = require './src/importModel.coffee'

form =
    SceneCanvas: SceneCanvas
    importModel: importModel

module.exports = form