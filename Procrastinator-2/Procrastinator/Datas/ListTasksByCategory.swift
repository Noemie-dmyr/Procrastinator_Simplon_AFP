//
//  listTasksByCategory.swift
//  Procrastinator
//
//  Created by apprenant112 on 23/09/2025.
//

import SwiftUI

// Catégories possibles :
// 0: Santé, 1: Travail, 2: Loisirs, 3: Études, 4: Budget, 5: Ménage

// MARK: - Liste horizontale des tâches par catégorie
struct ListTasksByCategory: View {
    // Catégorie demandée (-1 = toutes les tâches "à venir")
    let category: Int

    // Binding sur la liste des tâches globales
    // Permet de modifier les données (checkbox, status, etc.)
    @Binding var tasks: [TaskManager.SingleTask]

    // MARK: - Nom lisible de la catégorie
    var categoryName: String {
        switch category {
        case -1: return "A venir"
        case 0: return "Santé"
        case 1: return "Travail"
        case 2: return "Loisirs"
        case 3: return "Études"
        case 4: return "Budget"
        case 5: return "Ménage"
        default: return "Autres"
        }
    }

    // MARK: - Filtrage des tâches
    // On garde (index, task) pour pouvoir accéder à $tasks[index]
    var filteredWithIndex: [(index: Int, task: TaskManager.SingleTask)] {
        // Associe chaque tâche avec son index
        let enumerated = tasks.enumerated().map {
            (index: $0.offset, task: $0.element)
        }

        if category == -1 {
            // Cas spécial : toutes les tâches (non terminées), triées par date limite
            return
                enumerated
                .filter { $0.task.status == 0 || $0.task.status == 1 }  // à faire ou en cours
                .sorted {
                    ($0.task.dueDate ?? .distantFuture)
                        < ($1.task.dueDate ?? .distantFuture)
                }
        } else {
            // Sinon : uniquement celles de la catégorie + pas encore terminées
            return enumerated.filter {
                $0.task.category == category
                    && ($0.task.status == 0 || $0.task.status == 1)
            }
        }
    }

    // MARK: - Corps de la vue
    var body: some View {
        VStack(alignment: .leading) {
            let items = filteredWithIndex

            if !items.isEmpty {
                // Titre de section (nom de la catégorie)
                Text(categoryName)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 1)

                // Liste horizontale de cartes
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(items, id: \.index) { pair in
                            let i = pair.index
                            let task = pair.task

                            // Navigation vers la fiche de tâche
                            NavigationLink {
                                // Binding direct sur la tâche source
                                SingleTaskView(task: $tasks[i])
                            } label: {
                                // Carte affichant un résumé
                                CardView(
                                    cardTitle: task.title,
                                    category: task.category,
                                    dueDate: task.dueDate,
                                    singleTask: task
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.bottom, 8)
                }
            }
        }
    }
}
