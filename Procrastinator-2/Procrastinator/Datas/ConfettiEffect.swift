//
//  Confetti.swift
//  Procrastinator
//
//  Created by apprenant112 on 24/09/2025.
//

import SwiftUI

// MARK: - Modèle d’un confetti
struct ConfettiEffect: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var color: Color
    var size: CGFloat
    var angle: Angle
}

// MARK: - Vue principale (animation des confettis)
struct ConfettiView: View {
    // État : liste des confettis visibles
    @State private var confetties: [ConfettiEffect] = []

    // Palette de couleurs disponibles
    let colors: [Color] = [
        .red, .blue, .green, .yellow, .pink, .purple, .orange,
    ]

    // MARK: Corps de la vue
    var body: some View {
        ZStack {
            // Affichage de chaque confetti
            ForEach(confetties) { confetti in
                Rectangle()
                    .fill(confetti.color)
                    .frame(width: confetti.size, height: confetti.size)
                    .rotationEffect(confetti.angle)
                    .position(x: confetti.x, y: confetti.y)
                    .opacity(0.8)
            }
        }
        .ignoresSafeArea()
        .background(Color.black.opacity(0.05))
        .onAppear {
            withAnimation(Animation.linear(duration: 0.1)) {
                launchConfetti()
            }
        }
    }

    // MARK: - Animation des confettis
    func launchConfetti() {
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            // Limite du nombre de confettis pour éviter la surcharge
            if confetties.count > 100 {
                confetties.removeFirst(10)
            }

            // Création d’un nouveau confetti en haut de l’écran
            let screenWidth = UIScreen.main.bounds.width
            let newConfetti = ConfettiEffect(
                x: CGFloat.random(in: 0...screenWidth),
                y: -10,
                color: colors.randomElement() ?? .white,
                size: CGFloat.random(in: 5...15),
                angle: Angle(degrees: Double.random(in: 0...360))
            )
            withAnimation {
                confetties.append(newConfetti)
            }

            // Mise à jour de chaque confetti pour les faire tomber
            for i in confetties.indices {
                withAnimation(.easeIn(duration: Double.random(in: 2...4))) {
                    confetties[i].y += CGFloat.random(in: 300...600)
                    confetties[i].angle += Angle(
                        degrees: Double.random(in: -180...180)
                    )
                }
            }
        }
    }
}

// MARK: - Prévisualisation
#Preview {
    ConfettiView()
}
