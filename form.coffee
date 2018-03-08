window.THREE = require './src/lib/three.min.js'
window.FORM = window.THREE

{Scene} = require './src/Scene.coffee'
{Studio} = require './src/Studio.coffee'
{Model} = require './src/Model.coffee'

module.exports =
    Scene: Scene
    Studio: Studio
    Model: Model

    # MATERIALS

    MeshPhongMaterial: THREE.MeshPhongMaterial
    MeshNormalMaterial: THREE.MeshNormalMaterial
    MeshStandardMaterial: THREE.MeshStandardMaterial
    LineBasicMaterial: THREE.LineBasicMaterial
    LineDashedMaterial: THREE.LineDashedMaterial
    MeshBasicMaterial: THREE.MeshBasicMaterial
    MeshDepthMaterial: THREE.MeshDepthMaterial
    MeshLambertMaterial: THREE.MeshLambertMaterial
    MeshPhysicalMaterial: THREE.MeshPhysicalMaterial
    MeshToonMaterial: THREE.MeshToonMaterial
    PointsMaterial: THREE.PointsMaterial
    RawShaderMaterial: THREE.RawShaderMaterial
    ShaderMaterial: THREE.ShaderMaterial
    ShadowMaterial: THREE.ShadowMaterial
    SpriteMaterial: THREE.SpriteMaterial