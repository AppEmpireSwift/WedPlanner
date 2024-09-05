import SwiftUI
import Speech
import AVFoundation
import AudioToolbox

struct WPSearchField: View {
    @Binding var searchText: String
    @State private var isListening = false
    @State private var speechRecognizer = SFSpeechRecognizer(locale: Locale.current)
    @State private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    @State private var recognitionTask: SFSpeechRecognitionTask?
    @State private var audioEngine = AVAudioEngine()

    private let systemSoundID: SystemSoundID = 1104

    var body: some View {
        ZStack {
            Color.searchFieldBG
            
            HStack(spacing: 16) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search...", text: $searchText)
                    .foregroundColor(.black)
                    .padding(.vertical, 12)
                
                Button(action: {
                    toggleListening()
                }) {
                    Image(systemName: isListening ? "mic.fill" : "mic")
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 36)
        .cornerRadius(10)
        .onAppear(perform: requestSpeechRecognitionAuthorization)
    }
    
    private func requestSpeechRecognitionAuthorization() {
        SFSpeechRecognizer.requestAuthorization { status in
            switch status {
            case .authorized:
                print("Speech recognition authorized")
            case .denied, .restricted, .notDetermined:
                print("Speech recognition not available")
            @unknown default:
                print("Unknown authorization status")
            }
        }
    }
    
    private func toggleListening() {
        provideHapticFeedback()
        playSystemSound()
        
        if isListening {
            stopListening()
        } else {
            startListening()
        }
    }
    
    private func startListening() {
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        guard let recognitionRequest = recognitionRequest else { return }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
            if let result = result {
                searchText = result.bestTranscription.formattedString
            }
            
            if error != nil || result?.isFinal == true {
                stopListening()
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, when in
            recognitionRequest.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
            isListening = true
        } catch {
            print("Error starting audio engine: \(error.localizedDescription)")
        }
    }
    
    private func stopListening() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
        
        recognitionRequest = nil
        recognitionTask = nil
        
        isListening = false
    }
    
    private func provideHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
    
    private func playSystemSound() {
        AudioServicesPlaySystemSound(systemSoundID)
    }
}
