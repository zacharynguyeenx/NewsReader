import Ambassador
import Embassy
import Foundation

final class StubServer {
    // MARK: - Private properties

    private let eventLoop: EventLoop
    private var eventLoopThreadCondition: NSCondition?
    private var eventLoopThread: Thread?
    private let server: HTTPServer

    // MARK: - Initialiser

    init() throws {
        eventLoop = try SelectorEventLoop(selector: try KqueueSelector())
        server = DefaultHTTPServer(eventLoop: eventLoop, port: 8080, app: router.app)
    }

    // MARK: - Public

    let router = Router()

    /// Starts the HTTP server and initiates the event loop.
    func start() throws {
        try server.start()

        eventLoopThreadCondition = .init()
        eventLoopThread = .init(target: self, selector: #selector(runEventLoop), object: nil)
        eventLoopThread?.start()
    }

    /// Stops the HTTP server and the event loop.
    func stop() {
        guard let eventLoopThreadCondition else { return }
        server.stopAndWait()
        eventLoopThreadCondition.lock()
        eventLoop.stop()
        while eventLoop.running {
            if !eventLoopThreadCondition.wait(until: Date().addingTimeInterval(10)) {
                fatalError("Join eventLoopThread timeout")
            }
        }
        self.eventLoopThreadCondition = nil
        eventLoopThread = nil
    }
}

// MARK: - Private functions

private extension StubServer {
    @objc private func runEventLoop() {
        eventLoop.runForever()
        eventLoopThreadCondition?.lock()
        eventLoopThreadCondition?.signal()
        eventLoopThreadCondition?.unlock()
    }
}
