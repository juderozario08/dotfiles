pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Caelestia.Config
import qs.components
import qs.services

StyledRect {
    id: root

    readonly property color colour: Colours.palette.m3tertiary
    readonly property int padding: Config.bar.clock.background ? Tokens.padding.small : Tokens.padding.extraSmall / 2
    readonly property var font: Tokens.font.body.builders.small

    implicitHeight: Tokens.sizes.bar.innerWidth
    implicitWidth: layout.implicitWidth + root.padding * 2

    color: Qt.alpha(Colours.tPalette.m3surfaceContainer, Config.bar.clock.background ? Colours.tPalette.m3surfaceContainer.a : 0)
    radius: Tokens.rounding.full

    RowLayout {
        id: layout

        anchors.centerIn: parent
        spacing: Tokens.spacing.extraSmall

        Loader {
            Layout.alignment: Qt.AlignVCenter
            asynchronous: true
            active: Config.bar.clock.showIcon
            visible: active

            sourceComponent: MaterialIcon {
                text: "calendar_month"
                color: root.colour
            }
        }

        StyledText {
            Layout.alignment: Qt.AlignVCenter
            text: Time.format("ddd, MMM d")
            font: root.font.build()
            color: root.colour
        }

        StyledText {
            Layout.alignment: Qt.AlignVCenter
            text: "•"
            font: root.font.build()
            color: Colours.palette.m3outlineVariant
        }

        StyledText {
            Layout.alignment: Qt.AlignVCenter
            text: Time.format("HH:mm")
            font: root.font.build()
            color: root.colour
        }
    }
}
