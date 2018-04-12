# Framer Form
![alt text](https://github.com/emilwidlund/framer-form/blob/master/marketing/banner.png?raw=true)

Framer Form is a <a href="https://framer.com" target="_blank">Framer</a>-module built with the purpose of exposing a simple API for rendering 3D-graphics. Its purpose is to take existing 3D-techniques & libraries and expose them in the Framer Environment. It is built to support common Framer-concepts like Animations, States & Events in mind.

### What can you expect from this module?
As most people probably want to import their own models & 3D-meshes to their Framer Prototype, Framer Form will have solid support for a wide array of different file formats. Import anything from FBX, DAE & OBJ to JSON files, and have their respective materials applied with one simple line of code.

### What does the syntax look like?
Framer Form aims to deliver an easy and familiar syntax for all its components. Framer Form has 2 fundamental components that you will interact with.

### Documentation
- [Getting Started](documentation/GettingStarted.md)
- [Scenes](documentation/Scene.md)
- [Models](documentation/Model.md)
- [Lights](documentation/Light.md)

### Updates
| Date         | Summary        | Commit        |
| :---         | :---           | :---          |
| 2018-04-11   | Implemented support for damping inertia when Camera Orbiting. More information [here](documentation/Scene.md#if-orbitcontrols-is-enabled). | [0e8bec8](https://github.com/emilwidlund/framer-form/commit/0e8bec8b9f050b689a570a9642eb1ae951aab0d1) |
| 2018-04-11   | Implemented support for 3DS-models. | [9980f69](https://github.com/emilwidlund/framer-form/commit/9980f6909882f425f4d951d19a7e6efaeb06fb68) |
| 2018-04-10   | Fixed animate-method on Models, Lights & Cameras. | [5407e9e](https://github.com/emilwidlund/framer-form/commit/5407e9e1892d52299925adf742416b96382cf619) |

### Demo
<a href="https://framer.cloud/RzLsF">Interactive Framer Prototype</a>

### Built with
- Three.js
- Framer Library
- Inflate.js
- Underscore.js

### Contact
For any questions, highfives or concerns, please contact <a href="https://twitter.com/emilwidlund" target="_blank">me on Twitter</a>. If you found a bug, feel free to add an Issue to this repository and I'll take a look when I have time.
