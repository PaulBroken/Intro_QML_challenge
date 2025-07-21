import QtQuick

Window {
    id: window

    // TODO: change the size to ensure it forms the standard business card ratio of approx 1:1.586
    // HINT: you may wish to use a binding

    width: 700
    height: width / 1.586

    visible: true
    title: qsTr("Business Card")

    property color mycolor: Qt.rgba(0,153/255,51/255,1)

    component ContactInfo: QtObject {

        // This is a ContactInfo object which provides the properties to fill in.
        // You can create as many instances of this as you like with different property values.

        // show these properties all the time:
        property string name
        property url photo

        // Basic Info properties:
        property string occupation
        property string company

        // Detailed Info properties:
        property string address
        property string country
        property string phone
        property string email
        property url webSite
    }

    ContactInfo {
        id: myContactInfo

        // this is one example instance of a ContactInfo inline Component
        // showing how the properties are populated.

        name: "Paul Broken"
        photo: Qt.resolvedUrl("IDPhoto.png")
        occupation: "QML Enthusiast"
        company: "Indie Soft"
        address: "Candy Cane Lane"
        country: "North Pole"
        phone: "+01 2345 567 890"
        email: "email@server.com"
        webSite: Qt.url("https://www.qt.io")
    }

    /* Your solution should contain these key features:

        - A Text element for each of the ContactInfo properties.
        - The name and photo image should be shown all the time.
        - These should be grouped into two categories "Basic Info" and "Details".
        - Create a button using a MouseArea or TapHandler that can be used to
          toggle between showing the two categories of information.
        - Use a larger font size for the name
    */

    component TitleText: Text {
        font.pixelSize: 40
        font.bold: true
        color: mycolor
    }
    component HeadingText: Text {
        font.pixelSize: 20
    }
    component BodyText: Text {
        font.pixelSize: 18
    }

    component ButtonDetail: Rectangle {
        id: root
        width: 150
        height: 40
        color: "#dbdbdb"
        radius: height/2

        property alias text: textcontent.text
        signal clicked

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                root.clicked()
                root.state === 'clicked' ? root.state = "" : root.state = 'clicked';
            }
        }

        Text {
            id: textcontent
            text: qsTr("Text")
            font.pixelSize: 15
            anchors.horizontalCenterOffset: 0
            anchors.verticalCenterOffset: 0
            anchors.centerIn: parent
            font.bold: true
        }

        states: [
            State {
                name: "clicked"
                PropertyChanges {
                    root.color: mycolor
                    textcontent.color: "white"
                }
            }
        ]
    }

    Rectangle {
        id: rectangle1
        radius: 10
        border.color: mycolor
        border.width: 2
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 10
        anchors.bottomMargin: 10

        Item {
            anchors.fill: parent
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            anchors.topMargin: 20
            anchors.bottomMargin: 20

            TitleText {
                id: contactname
                x: 0
                y: 0
                text: myContactInfo.name
            }

            HeadingText {
                id: occupation
                x: 0
                y: 55
                text: myContactInfo.occupation +" at " + myContactInfo.company
            }

            Image {
                id: iDPhoto
                width: 262
                height: 251
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 30
                anchors.topMargin: 30
                source: "IDPhoto.png"
                fillMode: Image.PreserveAspectFit
            }

            ButtonDetail {
                id: rectangle
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 0
                anchors.bottomMargin: 15
                text: qsTr("Details")
                onClicked: contactdetails. visible =  !contactdetails.visible
            }

            Column {
                id: contactdetails
                x: 0
                y: 130
                width: 200
                height: 191
                spacing: 4

                BodyText {
                    id: address
                    text: myContactInfo.address
                }

                BodyText {
                    id: country
                    text: myContactInfo.country
                }

                BodyText {
                    id: phone
                    text: myContactInfo.phone
                }

                BodyText {
                    id: email
                    text: myContactInfo.email
                }

                BodyText {
                    id: website
                    textFormat: Text.RichText
                    text: "<a href=\"www.qt.io\">" + myContactInfo.webSite + "</a>"
                    onLinkActivated: Qt.openUrlExternally("http://www.qt.io")
                }

            }

        }


    }


}
