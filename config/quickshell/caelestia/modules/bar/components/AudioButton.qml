pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Caelestia.Config
import qs.components
import qs.components.controls
import qs.services
import qs.utils
import qs.modules.bar.popouts as BarPopouts

Item {
    id: root

    required property BarPopouts.Wrapper popouts

    implicitWidth: button.implicitWidth
    implicitHeight: button.implicitHeight

    ButtonBase {
        id: button

        implicitHeight: Tokens.sizes.bar.innerWidth
        implicitWidth: row.implicitWidth + Tokens.padding.small * 2
        radius: Tokens.rounding.full
        color: Colours.tPalette.m3surfaceContainer

        activeColour: Colours.palette.m3primary
        inactiveColour: Colours.tPalette.m3surfaceContainer
        activeOnColour: Colours.palette.m3onPrimary
        inactiveOnColour: Colours.palette.m3onSurface

        onClicked: {
            if (root.popouts.hasCurrent && root.popouts.currentName === "audio") {
                root.popouts.hasCurrent = false;
            } else {
                root.popouts.currentName = "audio";
                root.popouts.currentCenter = Qt.binding(() => root.mapToItem(root.parent, root.width / 2, 0).x);
                root.popouts.hasCurrent = true;
            }
        }

        WheelHandler {
            onWheel: event => {
                if (event.angleDelta.y > 0)
                    Audio.incrementVolume(0.02);
                else if (event.angleDelta.y < 0)
                    Audio.decrementVolume(0.02);
            }
        }

        RowLayout {
            id: row

            anchors.centerIn: parent
            spacing: Tokens.spacing.extraSmall / 2

            MaterialIcon {
                text: Icons.getVolumeIcon(Audio.volume, Audio.muted)
                color: Colours.palette.m3secondary
                fontStyle: Tokens.font.icon.small
                fill: 1
            }

            StyledText {
                text: Audio.muted ? qsTr("Muted") : `${Math.round(Audio.volume * 100)}%`
                font: Tokens.font.body.small
                color: Colours.palette.m3secondary
            }
        }
    }
}
