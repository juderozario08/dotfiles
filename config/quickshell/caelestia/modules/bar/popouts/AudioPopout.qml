pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Caelestia.Config
import qs.components
import qs.components.controls
import qs.services
import qs.utils

ColumnLayout {
    id: root

    required property PopoutState popouts

    width: Tokens.sizes.bar.networkWidth
    spacing: Tokens.spacing.small

    RowLayout {
        Layout.fillWidth: true
        Layout.topMargin: Tokens.padding.extraSmall
        spacing: Tokens.spacing.small

        MaterialIcon {
            text: "volume_up"
            color: Colours.palette.m3primary
            fontStyle: Tokens.font.icon.small
        }

        StyledText {
            Layout.fillWidth: true
            text: qsTr("Output Device")
            font: Tokens.font.body.builders.medium.weight(Font.Medium).build()
            color: Colours.palette.m3onSurface
        }
    }

    Repeater {
        model: ScriptModel {
            values: [...Audio.sinks].sort((a, b) => (a.description || a.name || "").localeCompare(b.description || b.name || "")).slice(0, 4)
        }

        StyledRect {
            id: sinkItem

            required property PwNode modelData
            readonly property bool isCurrent: Audio.sink?.id === sinkItem.modelData.id

            Layout.fillWidth: true
            implicitHeight: 28
            radius: Tokens.rounding.small
            color: sinkItem.isCurrent ? Qt.alpha(Colours.palette.m3primary, 0.12) : sinkState.containsMouse ? Qt.alpha(Colours.palette.m3onSurface, 0.06) : "transparent"

            StateLayer {
                id: sinkState

                onClicked: Audio.setAudioSink(sinkItem.modelData)
            }

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: Tokens.padding.small
                anchors.rightMargin: Tokens.padding.small
                spacing: Tokens.spacing.small

                MaterialIcon {
                    text: sinkItem.isCurrent ? "radio_button_checked" : "radio_button_unchecked"
                    color: sinkItem.isCurrent ? Colours.palette.m3primary : Colours.palette.m3onSurfaceVariant
                    fontStyle: Tokens.font.icon.small
                }

                StyledText {
                    Layout.fillWidth: true
                    text: sinkItem.modelData.description || sinkItem.modelData.name || qsTr("Unknown Device")
                    font: Tokens.font.body.small
                    elide: Text.ElideRight
                    color: sinkItem.isCurrent ? Colours.palette.m3primary : Colours.palette.m3onSurface
                }
            }
        }
    }

    RowLayout {
        Layout.fillWidth: true
        Layout.topMargin: Tokens.spacing.extraSmall / 2
        spacing: Tokens.spacing.small

        IconButton {
            type: IconButton.Tonal
            icon: Icons.getVolumeIcon(Audio.volume, Audio.muted)
            onClicked: Audio.setStreamMuted(Audio.sink, !Audio.muted)
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 2

            RowLayout {
                Layout.fillWidth: true

                StyledText {
                    Layout.fillWidth: true
                    text: qsTr("Volume")
                    font: Tokens.font.body.small
                    color: Audio.muted ? Colours.palette.m3outline : Colours.palette.m3onSurface
                }

                StyledText {
                    text: Audio.muted ? qsTr("Muted") : `${Math.round(Audio.volume * 100)}%`
                    font: Tokens.font.body.small
                    color: Colours.palette.m3secondary
                }
            }

            CustomMouseArea {
                Layout.fillWidth: true
                implicitHeight: 18

                onWheel: event => {
                    if (event.angleDelta.y > 0)
                        Audio.incrementVolume(0.02);
                    else if (event.angleDelta.y < 0)
                        Audio.decrementVolume(0.02);
                }

                StyledSlider {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    implicitHeight: 12
                    radius: Tokens.rounding.small

                    value: Audio.volume
                    enabled: !Audio.muted
                    onInteraction: value => Audio.setVolume(value)
                }
            }
        }
    }

    Rectangle {
        Layout.fillWidth: true
        Layout.topMargin: Tokens.spacing.extraSmall
        Layout.bottomMargin: Tokens.spacing.extraSmall
        implicitHeight: 1
        color: Colours.palette.m3outlineVariant
        opacity: 0.25
    }

    RowLayout {
        Layout.fillWidth: true
        spacing: Tokens.spacing.small

        MaterialIcon {
            text: "mic"
            color: Colours.palette.m3primary
            fontStyle: Tokens.font.icon.small
        }

        StyledText {
            Layout.fillWidth: true
            text: qsTr("Input Device")
            font: Tokens.font.body.builders.medium.weight(Font.Medium).build()
            color: Colours.palette.m3onSurface
        }
    }

    Repeater {
        model: ScriptModel {
            values: [...Audio.sources].sort((a, b) => (a.description || a.name || "").localeCompare(b.description || b.name || "")).slice(0, 4)
        }

        StyledRect {
            id: sourceItem

            required property PwNode modelData
            readonly property bool isCurrent: Audio.source?.id === sourceItem.modelData.id

            Layout.fillWidth: true
            implicitHeight: 28
            radius: Tokens.rounding.small
            color: sourceItem.isCurrent ? Qt.alpha(Colours.palette.m3primary, 0.12) : sourceState.containsMouse ? Qt.alpha(Colours.palette.m3onSurface, 0.06) : "transparent"

            StateLayer {
                id: sourceState

                onClicked: Audio.setAudioSource(sourceItem.modelData)
            }

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: Tokens.padding.small
                anchors.rightMargin: Tokens.padding.small
                spacing: Tokens.spacing.small

                MaterialIcon {
                    text: sourceItem.isCurrent ? "radio_button_checked" : "radio_button_unchecked"
                    color: sourceItem.isCurrent ? Colours.palette.m3primary : Colours.palette.m3onSurfaceVariant
                    fontStyle: Tokens.font.icon.small
                }

                StyledText {
                    Layout.fillWidth: true
                    text: sourceItem.modelData.description || sourceItem.modelData.name || qsTr("Unknown Device")
                    font: Tokens.font.body.small
                    elide: Text.ElideRight
                    color: sourceItem.isCurrent ? Colours.palette.m3primary : Colours.palette.m3onSurface
                }
            }
        }
    }

    RowLayout {
        Layout.fillWidth: true
        Layout.topMargin: Tokens.spacing.extraSmall / 2
        spacing: Tokens.spacing.small

        IconButton {
            type: IconButton.Tonal
            icon: Icons.getMicVolumeIcon(Audio.sourceVolume, Audio.sourceMuted)
            onClicked: Audio.setStreamMuted(Audio.source, !Audio.sourceMuted)
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 2

            RowLayout {
                Layout.fillWidth: true

                StyledText {
                    Layout.fillWidth: true
                    text: qsTr("Volume")
                    font: Tokens.font.body.small
                    color: Audio.sourceMuted ? Colours.palette.m3outline : Colours.palette.m3onSurface
                }

                StyledText {
                    text: Audio.sourceMuted ? qsTr("Muted") : `${Math.round(Audio.sourceVolume * 100)}%`
                    font: Tokens.font.body.small
                    color: Colours.palette.m3secondary
                }
            }

            CustomMouseArea {
                Layout.fillWidth: true
                implicitHeight: 18

                onWheel: event => {
                    if (event.angleDelta.y > 0)
                        Audio.incrementSourceVolume(0.02);
                    else if (event.angleDelta.y < 0)
                        Audio.decrementSourceVolume(0.02);
                }

                StyledSlider {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    implicitHeight: 12
                    radius: Tokens.rounding.small

                    value: Audio.sourceVolume
                    enabled: !Audio.sourceMuted
                    onInteraction: value => Audio.setSourceVolume(value)
                }
            }
        }
    }

    Rectangle {
        Layout.fillWidth: true
        Layout.topMargin: Tokens.spacing.extraSmall
        Layout.bottomMargin: Tokens.spacing.extraSmall
        implicitHeight: 1
        color: Colours.palette.m3outlineVariant
        opacity: 0.25
    }

    RowLayout {
        Layout.fillWidth: true
        spacing: Tokens.spacing.small

        MaterialIcon {
            text: "apps"
            color: Colours.palette.m3primary
            fontStyle: Tokens.font.icon.small
        }

        StyledText {
            Layout.fillWidth: true
            text: qsTr("Applications")
            font: Tokens.font.body.builders.medium.weight(Font.Medium).build()
            color: Colours.palette.m3onSurface
        }
    }

    StyledText {
        visible: Audio.streams.length === 0
        Layout.fillWidth: true
        Layout.leftMargin: Tokens.spacing.large
        text: qsTr("No apps playing audio")
        font: Tokens.font.body.small
        color: Colours.palette.m3onSurfaceVariant
    }

    Repeater {
        model: ScriptModel {
            values: [...Audio.streams].slice(0, 3)
        }

        RowLayout {
            id: streamItem

            required property PwNode modelData
            readonly property bool isMuted: streamItem.modelData?.audio?.muted ?? false
            readonly property real streamVol: streamItem.modelData?.audio?.volume ?? 0

            Layout.fillWidth: true
            Layout.topMargin: Tokens.spacing.extraSmall / 2
            spacing: Tokens.spacing.small

            IconButton {
                type: IconButton.Tonal
                icon: Icons.getVolumeIcon(streamItem.streamVol, streamItem.isMuted)
                onClicked: Audio.setStreamMuted(streamItem.modelData, !streamItem.isMuted)
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 2

                RowLayout {
                    Layout.fillWidth: true
                    spacing: Tokens.spacing.small

                    StyledText {
                        Layout.fillWidth: true
                        text: Audio.getStreamName(streamItem.modelData)
                        font: Tokens.font.body.small
                        elide: Text.ElideRight
                        color: streamItem.isMuted ? Colours.palette.m3outline : Colours.palette.m3onSurface
                    }

                    StyledText {
                        text: streamItem.isMuted ? qsTr("Muted") : `${Math.round(streamItem.streamVol * 100)}%`
                        font: Tokens.font.body.small
                        color: Colours.palette.m3secondary
                    }
                }

                CustomMouseArea {
                    Layout.fillWidth: true
                    implicitHeight: 18

                    onWheel: event => {
                        const step = 0.02;
                        if (event.angleDelta.y > 0)
                            Audio.setStreamVolume(streamItem.modelData, streamItem.streamVol + step);
                        else if (event.angleDelta.y < 0)
                            Audio.setStreamVolume(streamItem.modelData, streamItem.streamVol - step);
                    }

                    StyledSlider {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        implicitHeight: 12
                        radius: Tokens.rounding.small

                        value: streamItem.streamVol
                        enabled: !streamItem.isMuted
                        onInteraction: value => Audio.setStreamVolume(streamItem.modelData, value)
                    }
                }
            }
        }
    }

    IconTextButton {
        Layout.fillWidth: true
        Layout.topMargin: Tokens.spacing.small
        inactiveColour: Colours.palette.m3primaryContainer
        inactiveOnColour: Colours.palette.m3onPrimaryContainer
        verticalPadding: Tokens.padding.extraSmall
        text: qsTr("Open settings")
        icon: "settings"

        onClicked: root.popouts.detachRequested("audio")
    }
}
