import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [.black, .blue.opacity(0.6)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 40) {
                    Spacer()

                    Text("🎯")
                        .font(.system(size: 80))

                    Text("ألعاب الكيلاني")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)

                    Text("النسخة التجريبية")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.6))

                    Spacer()

                    NavigationLink(destination: ShootingGameView()) {
                        Text("ابدأ اللعب")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .frame(width: 250, height: 60)
                            .background(Color.blue)
                            .cornerRadius(15)
                    }

                    Spacer()

                    Text("© 2025 الكيلاني")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.5))
                        .padding(.bottom, 20)
                }
            }
        }
    }
}

#Preview {
    MenuView()
}