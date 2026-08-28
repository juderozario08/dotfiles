pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Caelestia.Config
import qs.components.containers
import qs.modules.bar as Bar

Scope {
    id: root

    required property ShellScreen screen
    required property Bar.BarWrapper bar

    ExclusionZone {
        anchors.left: true
        exclusiveZone: 0
    }

    ExclusionZone {
        anchors.top: true
        exclusiveZone: root.bar.exclusiveZone
    }

    ExclusionZone {
        anchors.right: true
        exclusiveZone: 0
    }

    ExclusionZone {
        anchors.bottom: true
        exclusiveZone: 0
    }

    component ExclusionZone: StyledWindow {
        screen: root.screen
        name: "border-exclusion"
        mask: Region {}
        implicitWidth: 1
        implicitHeight: 1
    }
}
