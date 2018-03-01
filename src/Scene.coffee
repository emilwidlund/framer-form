_ = Framer._

class exports.Scene extends Layer
    constructor: (properties={}) ->
        super _.defaults properties,
            backgroundColor: '#000'
        

        # RENDERER
        
        @renderer = new THREE.WebGLRenderer
            antialias: true
            devicePixelRatio: window.devicePixelRatio
            alpha: true
        
        @_element.appendChild @renderer.domElement
        @renderer.domElement.style.width = '100%'
        @renderer.domElement.style.height = '100%'
        @renderer.setSize(@width, @height)


        # SCENE

        @scene = new THREE.Scene


        # CAMERA

        @camera = new THREE.PerspectiveCamera(35, @width / @height, 0.1, 10000)
        @camera.position.x = 0
        @camera.position.y = 0
        @camera.position.z = 10


        # RAYCASTER

        @raycaster = new THREE.Raycaster
        @mouse = new THREE.Vector2
        @intersected = null
        @intersectedEventEmitted = false

        onMouseMove = (e) =>
            @mouse.x = (e.clientX / @width) * 2 - 1
            @mouse.y = -(e.clientY / @height) * 2 + 1
        
        @on 'mousemove', onMouseMove, false

        @on 'mousedown', ->
            if @intersected
                @intersected.object.dispatchEvent {type: 'mousedown'}
        
        @on 'mouseup', ->
            if @intersected
                @intersected.object.dispatchEvent {type: 'mouseup'}


        # ANIMATION LOOP

        @loop()



    loop: () =>
        requestAnimationFrame @loop

        if @animationLoop
            @animationLoop()
        
        @handleRaycaster()

        @renderer.render @scene, @camera
    
    handleRaycaster: () =>
        @raycaster.setFromCamera @mouse, @camera
        intersects = @raycaster.intersectObjects @scene.children

        if intersects.length && @intersected != intersects[0]
            @intersected = intersects[0]
        
        if @intersected && !intersects.length
            @intersected.object.dispatchEvent {type: 'mouseout'}
            @intersected.object.dispatchEvent {type: 'onmouseout'}
        
        if !intersects.length
            @intersected = null
            @intersectedEventEmitted = false
        
        if !@intersectedEventEmitted && @intersected
            @intersected.object.dispatchEvent {type: 'mouseover'}
            @intersected.object.dispatchEvent {type: 'onmouseover'}
            @intersectedEventEmitted = true