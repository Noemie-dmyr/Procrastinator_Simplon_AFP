//
//  TheWheelView.swift
//  Procrastinator
//
//  Created by apprenant112 on 24/09/2025.
//

import SwiftUI

// MARK: - Vue de la roue des défis
struct TheWheelView: View {
    // MARK: - États internes
    @State private var rotation: Double = 0
    @State private var selectedSentence: String =
        "Clique sur la roue pour découvrir le défi du jour !"
    @State private var isSpinning = false

    // Pour fermer la vue (popup)
    @Environment(\.dismiss) var dismiss

    // MARK: - Contenu (phrases de défis)
    var sentences: [String] = [
        "Va faire la cuisine.",
        "Va faire les courses.",
        "Appelle ta mère !",
        "Prends rendez-vous chez le médecin.",
        "Va chez l'ophtalmo.",
    ]

    // MARK: - Corps de la vue
    var body: some View {
        VStack {
            // Bouton de fermeture
            HStack {
                Spacer()
                Button(
                    action: { dismiss() },
                    label: {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45)
                            .padding(.horizontal)  // FIXME: vide
                            .foregroundStyle(.themeDarker)
                    }
                )
            }
            .padding(.bottom, 80)

            // Titre
            Text("🎉 Défi du jour 🎉")
                .font(.title)
                .foregroundStyle(.themeDarker)
                .fontWeight(.bold)

            // MARK: Roue + flèche
            ZStack(alignment: .top) {
                // Roue cliquable
                Button {
                    // Lancer l’animation de rotation
                    withAnimation(.easeOut(duration: 2)) {
                        rotation += Double.random(in: 10...800)
                    }

                    // Choisir une phrase après la rotation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        let randomIndex = Int.random(in: 0..<sentences.count)
                        withAnimation {
                            selectedSentence = sentences[randomIndex]
                        }
                    }
                } label: {
                    Image(.wheel)
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(.degrees(rotation))
                        .frame(width: 300, height: 300)
                }
                .padding()

                // Flèche fixe
                Image(.arrow)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 60)
            }

            // MARK: Phrase affichée après le tirage
            if !selectedSentence.isEmpty {
                Text(selectedSentence)
                    .font(.title3)
                    .padding(30)
                    .foregroundStyle(.black)
                    .background(.mediumPinkHealth)
                    .cornerRadius(15)
            }
        }
        Spacer()
    }
}

// MARK: - Prévisualisation
#Preview {
    TheWheelView()
}
