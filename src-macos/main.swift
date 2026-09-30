// MappAzzone — wrapper nativo macOS (WKWebView, 100% offline, nessun browser esterno).
// Compilare con: ./build.sh
import Cocoa
import WebKit

final class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    func applicationDidFinishLaunching(_ notification: Notification) {
        let config = WKWebViewConfiguration()
        config.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        config.mediaTypesRequiringUserActionForPlayback = []

        let view = WKWebView(frame: .zero, configuration: config)
        view.autoresizingMask = [.width, .height]

        let www = Bundle.main.resourceURL!.appendingPathComponent("www", isDirectory: true)
        let index = www.appendingPathComponent("index.html", isDirectory: false)
        view.loadFileURL(index, allowingReadAccessTo: www)

        let rect = NSRect(x: 0, y: 0, width: 1440, height: 900)
        window = NSWindow(contentRect: rect,
                          styleMask: [.titled, .closable, .miniaturizable, .resizable],
                          backing: .buffered, defer: false)
        window.title = "MappAzzone"
        window.contentView = view
        window.center()
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)

        buildMenu()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    private func buildMenu() {
        let main = NSMenu()
        let appItem = NSMenuItem()
        main.addItem(appItem)
        let appMenu = NSMenu()
        appItem.submenu = appMenu
        appMenu.addItem(NSMenuItem(title: "Esci da MappAzzone", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

        let viewItem = NSMenuItem()
        main.addItem(viewItem)
        let viewMenu = NSMenu(title: "Vista")
        viewItem.submenu = viewMenu
        let fs = NSMenuItem(title: "Schermo intero", action: #selector(NSWindow.toggleFullScreen(_:)), keyEquivalent: "f")
        fs.keyEquivalentModifierMask = [.control, .command]
        viewMenu.addItem(fs)

        NSApp.mainMenu = main
    }
}

let app = NSApplication.shared
app.setActivationPolicy(.regular)
let delegate = AppDelegate()
app.delegate = delegate
app.run()
