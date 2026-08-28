pragma ComponentBehavior: Bound

import QtQuick
import Caelestia.Config
import qs.components
import qs.services
import qs.utils

Item {
    id: root

    required property var bar
    required property Brightness.Monitor monitor
    property color colour: Colours.palette.m3primary

    readonly property string windowTitle: {
        const title = Hypr.activeToplevel?.title;
        if (!title)
            return qsTr("Desktop");
        let result = title;
        if (Config.bar.activeWindow.compact) {
            // " - " (standard hyphen), " — " (em dash), " – " (en dash)
            const parts = title.split(/\s+[\-\u2013\u2014]\s+/);
            if (parts.length > 1)
                result = parts[parts.length - 1].trim();
        }
        const maxLen = 38;
        if (result.length > maxLen)
            result = result.slice(0, maxLen).trim() + "...";
        return result;
    }

    readonly property int maxWidth: {
        const leftSpace = (bar.width / 2) - 140 - (root.mapToItem(bar, 0, 0).x || 150);
        return Math.max(100, leftSpace > 0 ? leftSpace : 250);
    }
    property Title current: text1

    clip: true
    implicitHeight: Math.max(icon.implicitHeight, current.implicitHeight)
    implicitWidth: icon.implicitWidth + current.implicitWidth + current.anchors.leftMargin

    Loader {
        asynchronous: true
        anchors.fill: parent
        active: !Config.bar.activeWindow.showOnHover

        sourceComponent: MouseArea {
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onPositionChanged: {
                const popouts = root.bar.popouts;
                if (popouts.hasCurrent && popouts.currentName !== "activewindow")
                    popouts.hasCurrent = false;
            }
            onClicked: {
                const popouts = root.bar.popouts;
                if (popouts.hasCurrent) {
                    popouts.hasCurrent = false;
                } else {
                    popouts.currentName = "activewindow";
                    popouts.currentCenter = root.mapToItem(root.bar, root.implicitWidth / 2, 0).x;
                    popouts.hasCurrent = true;
                }
            }
        }
    }

    MaterialIcon {
        id: icon

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left

        animate: true
        text: Icons.getAppCategoryIcon(Hypr.activeToplevel?.lastIpcObject.class, "desktop_windows")
        color: root.colour
    }

    Title {
        id: text1
    }

    Title {
        id: text2
    }

    TextMetrics {
        id: metrics

        text: root.windowTitle
        font: root.Tokens.font.body.builders.small.letterSpacing(1.4).build()
        elide: Qt.ElideRight
        elideWidth: root.maxWidth - icon.width - Tokens.spacing.small

        onTextChanged: {
            const next = root.current === text1 ? text2 : text1;
            next.text = elidedText;
            root.current = next;
        }
        onElideWidthChanged: root.current.text = elidedText
    }

    Behavior on implicitWidth {
        Anim {}
    }

    component Title: StyledText {
        id: text

        anchors.verticalCenter: icon.verticalCenter
        anchors.left: icon.right
        anchors.leftMargin: Tokens.spacing.small

        font: metrics.font
        color: root.colour
        opacity: root.current === this ? 1 : 0
        horizontalAlignment: Text.AlignLeft

        Behavior on opacity {
            Anim {
                type: Anim.DefaultEffects
            }
        }
    }
}
