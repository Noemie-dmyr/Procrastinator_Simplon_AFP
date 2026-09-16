//
//  ContentView.swift
//  ProfilView
//
//  Created by apprenant81 on 24/09/2025.
//

import SwiftUI

// MARK: - Vue: Page de profil
struct PageProfilView: View {
    @State private var toggle = true

    var body: some View {
        VStack(spacing: 16) {

            // MARK: - Avatar
            ZStack(alignment: .center) {
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.themeLight)

                Image("ppMyriam")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
            }

            // MARK: - Informations principales
            VStack(spacing: 8) {
                Text("Myriam")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.themeDarker)

                ZStack {
                    Rectangle()
                        .frame(width: 100, height: 50)
                        .cornerRadius(20)
                        .foregroundStyle(.themeLight)

                    Text("Niveau 3")
                        .foregroundStyle(.themeDarker)
                }
                .padding(9)

                Text("27")
                    .font(.title3)
                    .fontWeight(.semibold)

                Text("Tâches effectuées")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            // MARK: - Statistiques par catégorie
            List(styleTask) { stat in
                HStack {
                    Image(systemName: stat.logo)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(stat.taskColor)
                        .frame(width: 45)
                        .padding()

                    Text(stat.taskName)

                    Spacer()

                    Text(stat.taskNumber)
                        .frame(width: 50)
                }
            }
        }
        .padding()
    }
}

// MARK: - Prévisualisation
#Preview {
    PageProfilView()
}

// MARK: - Modèle Statistique
struct Stat: Identifiable {
    var id = UUID()
    var logo: String
    var taskColor: Color
    var taskName: String
    var taskNumber: String
}

// MARK: - Données d'exemple
var styleTask = [
    Stat(
        logo: "graduationcap.fill",
        taskColor: .darkBlueSchool,
        taskName: "École",
        taskNumber: "5"
    ),
    Stat(
        logo: "suitcase.fill",
        taskColor: .darkBrownWork,
        taskName: "Travail",
        taskNumber: "7"
    ),
    Stat(
        logo: "cross.fill",
        taskColor: .darkPinkHealth,
        taskName: "Santé",
        taskNumber: "2"
    ),
    Stat(
        logo: "bubbles.and.sparkles.fill",
        taskColor: .darkBlueCleaning,
        taskName: "Ménage",
        taskNumber: "3"
    ),
    Stat(
        logo: "eurosign",
        taskColor: .darkGreenBudget,
        taskName: "Budget",
        taskNumber: "4"
    ),
    Stat(
        logo: "paintbrush.fill",
        taskColor: .darkOrangeHobbies,
        taskName: "Loisirs",
        taskNumber: "5"
    ),
    Stat(
        logo: "ellipsis.circle.fill",
        taskColor: .darkFushiaOther,
        taskName: "Autres",
        taskNumber: "1"
    ),
]
