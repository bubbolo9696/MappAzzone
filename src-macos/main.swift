// MappAzzone — wrapper nativo macOS (WKWebView, 100% offline, nessun browser esterno).
// Compilare con: ./build.sh
import Cocoa
import WebKit

final class AppDelegate: NSObject, NSApplicationDelegate, WKUIDelegate, NSWindowDelegate {
    var window: NSWindow!
    var popups: [NSWindow] = [] // finestre output (trascinale sul proiettore)

    func applicationDidFinishLaunching(_ notification: Notification) {
        let config = WKWebViewConfiguration()
        config.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        config.mediaTypesRequiringUserActionForPlayback = []

        let view = WKWebView(frame: .zero, configuration: config)
        view.uiDelegate = self
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
        return popups.isEmpty
    }

    // popup window.open() -> vera finestra output separata
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        let popup = WKWebView(frame: NSRect(x: 0, y: 0, width: 1280, height: 720), configuration: configuration)
        popup.uiDelegate = self
        let win = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 1280, height: 720),
                           styleMask: [.titled, .closable, .miniaturizable, .resizable],
                           backing: .buffered, defer: false)
        win.title = "MappAzzone — OUTPUT"
        win.contentView = popup
        win.delegate = self
        win.center()
        win.makeKeyAndOrderFront(nil)
        popups.append(win)
        return popup
    }

    func webViewDidClose(_ webView: WKWebView) {
        for w in popups where w.contentView === webView { w.close() }
        popups.removeAll { $0.contentView === webView }
    }

    func windowWillClose(_ notification: Notification) {
        if let w = notification.object as? NSWindow {
            popups.removeAll { $0 === w }
        }
    }

    // <input type=file> altrimenti non apre nulla in WKWebView
    func webView(_ webView: WKWebView, runOpenPanelWith parameters: WKOpenPanelParameters, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping ([URL]?) -> Void) {
        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowsMultipleSelection = parameters.allowsMultipleSelection
        panel.message = "Scegli i file da caricare in MappAzzone"
        let done: (NSApplication.ModalResponse) -> Void = { resp in
            completionHandler(resp == .OK ? panel.urls : nil)
        }
        if let win = webView.window {
            panel.beginSheetModal(for: win, completionHandler: done)
        } else {
            done(panel.runModal())
        }
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
