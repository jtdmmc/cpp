import QtQuick3D

import QtQuick

Window {
    width: 800
    height: 450
    visible: true
    View3D {
        anchors.fill: parent
        camera: camera
        environment: SceneEnvironment {
            backgroundMode: SceneEnvironment.SkyBox
            lightProbe: Texture {
                source: "skybox.hdr"
            }
            probeExposure: 3
        }
        PerspectiveCamera {
            id: camera
            position: Qt.vector3d(0, 300, 500)
            eulerRotation.x: -25
        }
        DirectionalLight {
            eulerRotation.x: -30
            eulerRotation.y: -70
        }
        RandomInstancing {
            id: randomTable
            instanceCount: 20000
            position: InstanceRange { from: Qt.vector3d(-5000, -2000, -9000); to: Qt.vector3d(5000, 200, 500) }
            rotation: InstanceRange { from: Qt.vector3d(20, 0, -45); to: Qt.vector3d(60, 0, 45) }
            color: InstanceRange { from: Qt.rgba(0.1, 0.1, 0.1, 1); to: Qt.rgba(1, 1, 1, 1) }
        }
        Model {
            instancing: randomTable
            source: "torus.mesh"
            materials: PrincipledMaterial { metalness: 1.0; roughness: 0.2; baseColor: "#ffffff" }
        }
    }
}
