import Cocoa

func printAppearance() {
    if NSAppearance.currentDrawing().bestMatch(from: [.aqua, .darkAqua]) == .aqua {
        print("light")
    } else {
        print("dark")
    }
}

setbuf(stdout, nil)
DistributedNotificationCenter.default.addObserver(
    forName: Notification.Name("AppleInterfaceThemeChangedNotification"),
    object: nil,
    queue: nil
) { _ in
    printAppearance()
}

NSApplication.shared.run()
