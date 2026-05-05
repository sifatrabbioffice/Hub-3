import SwiftUI
import MetalKit

class EmulatorManager: ObservableObject {
    @Published var isRunning = false
    @Published var logOutput = "Ready to launch..."
    
    // Simulating the launch of an x86_64 binary on ARM64
    func launchGame(exeName: String) {
        logOutput = "Initializing Wine prefix...\n"
        logOutput += "Mapping C:/Games/\(exeName)...\n"
        
        // In a real build, this triggers the Box64/Wine binary
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isRunning = true
            self.logOutput += "DirectX 12 Translation Layer Active.\n"
            self.logOutput += "Running \(exeName) at high priority."
        }
    }
}

struct EmulatorView: View {
    @ObservedObject var manager = EmulatorManager()
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if manager.isRunning {
                // Placeholder for the Metal-rendered Game Window
                VStack {
                    Text("LOCAL EMULATION ACTIVE")
                        .foregroundColor(.green).bold()
                    Spacer()
                    // Virtual Joystick Overlay would go here
                    Button("STOP GAME") { manager.isRunning = false }
                        .padding().background(Color.red).cornerRadius(10)
                }
            } else {
                VStack(spacing: 25) {
                    Text("GAMEHUB LOCAL")
                        .font(.system(size: 35, weight: .black))
                        .foregroundColor(.blue)
                    
                    ScrollView {
                        Text(manager.logOutput)
                            .font(.system(.caption, design: .monospaced))
                            .foregroundColor(.gray)
                            .padding()
                    }
                    .frame(height: 150)
                    .background(Color.white.opacity(0.05))
                    
                    Button(action: { manager.launchGame(exeName: "GTA5.exe") }) {
                        HStack {
                            Image(systemName: "play.fill")
                            Text("RUN GTA V (LOCAL)")
                        }
                        .padding().frame(width: 250).background(Color.green).foregroundColor(.black).cornerRadius(12)
                    }
                }
            }
        }
    }
}
