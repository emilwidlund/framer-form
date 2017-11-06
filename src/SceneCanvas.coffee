_ = Framer._

class exports.SceneCanvas extends Layer
    constructor: (properties={}) ->
        super _.defaults properties,
            backgroundColor: '#000'

        @renderer = new THREE.WebGLRenderer
            antialias: true
            devicePixelRatio: window.devicePixelRatio
            alpha: true
        
        @_element.appendChild @renderer.domElement
        @renderer.domElement.style.width = '100%'
        @renderer.domElement.style.height = '100%'

        @renderer.setSize(@width, @height)

        @scene = new THREE.Scene

        @camera = new THREE.PerspectiveCamera(35, @width / @height, 0.1, 10000)
        @camera.position.x = 0
        @camera.position.y = 0
        @camera.position.z = 10