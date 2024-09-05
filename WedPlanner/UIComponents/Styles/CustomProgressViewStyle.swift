import SwiftUI

struct CustomProgressViewStyle: ProgressViewStyle {
    let trackColor: Color = .mainBG
    let progressColor: Color = .standartDarkText
    let cornerRadius: CGFloat = 6

    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(trackColor)
                .frame(height: 12)

            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(progressColor)
                .frame(width: max(CGFloat(configuration.fractionCompleted ?? 0) * 200, 0), height: 12)
        }
    }
}
