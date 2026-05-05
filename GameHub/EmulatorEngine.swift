import Foundation

class EmulatorEngine: ObservableObject {
    @Published var isRunning = false
    @Published var gameMode: GameMode = .local64bit

    enum GameMode {
        case local64bit
        case cloud
    }

    func launchGame(name: String) {
        print("Initializing 64-bit environment for \(name)...")
        // Logic for high-performance local execution or cloud socket connection
        self.isRunning = true
    }
}
