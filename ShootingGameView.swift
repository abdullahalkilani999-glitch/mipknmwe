import SwiftUI

struct Target: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
}

struct ShootingGameView: View {
    @State private var targets: [Target] = []
    @State private var score = 0
    @State private var timeLeft = 30
    @State private var gameOver = false
    @State private var timer: Timer? = nil

    var body: some View {
        GeometryReader { geo in
            ZStack {
                LinearGradient(
                    colors: [.black, .red.opacity(0.4)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                // الأهداف
                ForEach(targets) { target in
                    Circle()
                        .fill(Color.red)
                        .frame(width: 60, height: 60)
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 3)
                        )
                        .position(x: target.x, y: target.y)
                        .onTapGesture {
                            hit(target)
                        }
                }

                // شريط المعلومات
                VStack {
                    HStack {
                        Text("النقاط: \(score)")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                        Spacer()
                        Text("الوقت: \(timeLeft)")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                    }
                    .padding()
                    Spacer()
                }

                // شاشة النهاية
                if gameOver {
                    VStack(spacing: 20) {
                        Text("انتهى الوقت!")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                        Text("نتيجتك: \(score)")
                            .font(.title)
                            .foregroundColor(.white)
                        Button("العب مرة أخرى") {
                            restartGame(size: geo.size)
                        }
                        .font(.title2.bold())
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .padding()
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(20)
                }
            }
            .onAppear {
                restartGame(size: geo.size)
            }
        }
    }

    func restartGame(size: CGSize) {
        score = 0
        timeLeft = 30
        gameOver = false
        targets = []
        timer?.invalidate()

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeLeft > 0 {
                timeLeft -= 1
                spawnTarget(size: size)
            } else {
                gameOver = true
                timer?.invalidate()
            }
        }
    }

    func spawnTarget(size: CGSize) {
        let newTarget = Target(
            x: CGFloat.random(in: 50...(size.width - 50)),
            y: CGFloat.random(in: 100...(size.height - 100))
        )
        targets = [newTarget]
    }

    func hit(_ target: Target) {
        score += 1
        targets.removeAll { $0.id == target.id }
    }
}

#Preview {
    ShootingGameView()
}