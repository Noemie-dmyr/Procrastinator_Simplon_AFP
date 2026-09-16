//
//  CongratulationView.swift
//  Procrastinator
//
//  Created by apprenant112 on 24/09/2025.
//

import SwiftUI

// MARK: - Vue de félicitations
struct CongratulationView: View {
    @Environment(\.dismiss) var dismiss

    // MARK: Corps de la vue
    var body: some View {
        ZStack(alignment: .top) {
            // Fond principal
            Color(.themeLight)
                .ignoresSafeArea()

            VStack {

                Spacer()

                // MARK: Illustration centrale
                ZStack {
                    Circle()
                        .foregroundStyle(.white)
                        .frame(width: 250)
                    Image("catHead")
                }

                // Titre de félicitations
                Text("WOUHOOOOU !!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.themeDarker)
                    .padding()

                Spacer()

                // Message secondaire
                Text("Tu as vaincu la procrastination ! Quelle star !!")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.horizontal)
                    .background(.white)
                    .cornerRadius(8)

                Spacer()

            }
            .padding()

            // MARK: Effet visuel (confettis)
            ConfettiView()

            HStack {
                Spacer()

                // MARK: Bouton de fermeture
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45)
                        .padding(.horizontal, 16)
                        .foregroundStyle(.themeDarker)
                }
            }
        }
    }
}

// MARK: - Prévisualisation
#Preview {
    CongratulationView()
}
