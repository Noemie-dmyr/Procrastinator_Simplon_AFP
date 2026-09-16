//
//  DiagramTaskProgress.swift
//  Procrastinator
//
//  Created by apprenant112 on 19/09/2025.
//

import SwiftUI

struct DiagramTaskProgress: View {
    var progress: Double = 0.6

    var body: some View {
        ZStack {
            // Cercle de fond (piste)
            Circle()
                .stroke(Color.themeLight, lineWidth: 15)

            // Cercle de progression
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    progress == 1 ? Color.green : Color.themeDark,
                    style: StrokeStyle(
                        lineWidth: 15,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))

            // Texte au centre
            if progress != 1 {
                Text("\(Int(progress * 100))%")
                    .font(.title)
                    .bold()
                    .foregroundColor(.themeDarker)
                    .offset(y: -8)
                Text("Progression").offset(y: 12).font(.footnote)
            } else {
                Text("Bravo !").font(.title2).fontWeight(.heavy)
            }
        }
        .frame(width: 100, height: 100)
        .padding(15)
        .animation(.default, value: progress)
    }
}

#Preview { DiagramTaskProgress(progress: 0.8) }
