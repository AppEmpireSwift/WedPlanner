import SwiftUI

struct LineSeparaterView: View {
    var body: some View {
        Rectangle()
            .fill(Color.sGray)
            .frame(maxWidth: .infinity, maxHeight: 1)
    }
}

#Preview {
    LineSeparaterView()
}
