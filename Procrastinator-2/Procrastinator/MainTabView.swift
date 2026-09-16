//
//  Tab.swift
//  Procrastinator
//
//  Created by Noémie De Meyer on 21/09/2025.
//

import SwiftUI

// MARK: - Modèle principal des tâches
struct TaskManager {
    // MARK: Stockage des tâches
    var tasks: [SingleTask] = []

    // MARK: - Modèle d'une tâche
    struct SingleTask {
        // MARK: Métadonnées
        var title: String
        var detail: String?
        var createdAt: Date = .init()
        var dueDate: Date?

        /// Retard si la date limite est dépassée
        var isOverdue: Bool {
            guard let dueDate else { return false }
            return dueDate < Date()
        }

        // MARK: Catégorisation & état
        // Catégorie simplifiée via Int :
        // 0: Santé, 1: Travail, 2: Loisirs, 3: Études, 4: Budget, 5: Ménage, 6: Autres
        var category: Int

        // Statut : 0: À faire, 1: En cours, 2: Terminé
        var status: Int = 0

        // Priorité : 0: Basse, 1: Normale, 2: Haute, 3: Critique
        var priority: Int = 1

        // MARK: Jalons
        var milestones: [Milestone] = []

        // MARK: - Modèle d'un jalon
        struct Milestone {
            var title: String
            var dueDate: Date?

            /// Retard si la date du jalon est dépassée
            var isOverdue: Bool {
                guard let dueDate else { return false }
                return dueDate < Date()
            }

            // Statut : 0: À faire, 1: Terminé
            var status: Int = 0
            var notes: String?
        }
    }
}

// MARK: - Données d’exemple (10 tâches)
let sampleTasks: [TaskManager.SingleTask] = [

    // 1) Santé
    .init(
        title: "Aller chez le dentiste",
        detail: "Contrôle annuel + détartrage",
        dueDate: Calendar.current.date(byAdding: .day, value: 7, to: .now),
        category: 0,
        status: 0,  // À faire
        priority: 2,  // Haute
        milestones: [
            .init(title: "Prendre rendez-vous", dueDate: nil, status: 1),
            .init(title: "Aller au cabinet", dueDate: nil, status: 0),
        ]
    ),

    // 2) Santé
    .init(
        title: "Préparer les repas de la semaine",
        detail: "Batch cooking dimanche après-midi",
        dueDate: Calendar.current.date(byAdding: .day, value: 2, to: .now),
        category: 0,
        status: 1,  // En cours
        priority: 1,  // Normale
        milestones: [
            .init(title: "Faire la liste de courses", dueDate: nil, status: 1),
            .init(title: "Cuisine du dimanche", dueDate: nil, status: 0),
        ]
    ),

    // 3) Travail
    .init(
        title: "Boucler la présentation trimestrielle",
        detail: "Slides ventes + prévisions Q4",
        dueDate: Calendar.current.date(byAdding: .day, value: 3, to: .now),
        category: 1,
        status: 1,
        priority: 3,  // Critique
        milestones: [
            .init(title: "Rassembler les chiffres", dueDate: nil, status: 1),
            .init(title: "Mettre à jour les graphes", dueDate: nil, status: 0),
            .init(title: "Répétition orale", dueDate: nil, status: 0),
        ]
    ),

    // 4) Travail
    .init(
        title: "Envoyer le rapport hebdo",
        detail: "Inclure le suivi de projet et les alertes risques",
        dueDate: Calendar.current.date(byAdding: .day, value: 1, to: .now),
        category: 1,
        status: 0,
        priority: 2,
        milestones: [
            .init(title: "Collecte des données", dueDate: nil, status: 0),
            .init(title: "Mise en forme du doc", dueDate: nil, status: 0),
            .init(title: "Envoi au manager", dueDate: nil, status: 0),
        ]
    ),

    // 5) Loisirs
    .init(
        title: "Apprendre un morceau à la guitare",
        detail: "20 minutes par jour, tempo 90 bpm",
        dueDate: nil,
        category: 2,
        status: 0,
        priority: 0,  // Basse
        milestones: [
            .init(title: "Mémoriser les accords", dueDate: nil, status: 1),
            .init(title: "Passages propres", dueDate: nil, status: 0),
        ]
    ),

    // 6) Loisirs
    .init(
        title: "Regarder un film culte",
        detail: "Sélectionner dans la liste 'classiques à voir'",
        dueDate: nil,
        category: 2,
        status: 0,
        priority: 0,
        milestones: [
            .init(title: "Choisir le film", dueDate: nil, status: 0),
            .init(title: "Préparer popcorn", dueDate: nil, status: 0),
        ]
    ),

    // 7) Études
    .init(
        title: "Réviser chapitre 5 – Probabilités",
        detail: "Exercices pairs + fiche mémo",
        dueDate: Calendar.current.date(byAdding: .day, value: -1, to: .now),  // hier
        category: 3,
        status: 0,
        priority: 2,
        milestones: [
            .init(title: "Relecture du cours", dueDate: nil, status: 0),
            .init(title: "Exercices d’application", dueDate: nil, status: 0),
        ]
    ),

    // 8) Budget
    .init(
        title: "Faire le point sur les dépenses",
        detail: "Analyser budget mensuel avant vacances",
        dueDate: Calendar.current.date(byAdding: .day, value: 10, to: .now),
        category: 4,
        status: 0,
        priority: 1,
        milestones: [
            .init(title: "Lister les dépenses", dueDate: nil, status: 0),
            .init(title: "Comparer au budget", dueDate: nil, status: 0),
        ]
    ),

    // 9) Ménage
    .init(
        title: "Nettoyer le garage",
        detail: "Ranger outils + sortir cartons",
        dueDate: Calendar.current.date(byAdding: .day, value: 5, to: .now),
        category: 5,
        status: 0,
        priority: 1,
        milestones: [
            .init(title: "Sortir les cartons", dueDate: nil, status: 0),
            .init(title: "Balayer le sol", dueDate: nil, status: 0),
            .init(title: "Ranger outils", dueDate: nil, status: 0),
        ]
    ),

    // 10) Autres
    .init(
        title: "Organiser l’anniversaire",
        detail: "Soirée surprise samedi prochain",
        dueDate: Calendar.current.date(byAdding: .day, value: 5, to: .now),
        category: 6,
        status: 1,  // En cours
        priority: 1,
        milestones: [
            .init(title: "Faire la liste des invités", dueDate: nil, status: 1),
            .init(title: "Réserver le restaurant", dueDate: nil, status: 1),
            .init(title: "Acheter le cadeau", dueDate: nil, status: 0),
        ]
    ),
]

// MARK: - Vue principale avec barre d’onglets
struct MainTabView: View {
    /// État local : liste des tâches (préremplie avec les échantillons)
    @State var allTasks = sampleTasks

    var body: some View {
        TabView {

            // MARK: Onglet Tâches
            TasksView(exampleTasks: $allTasks)
                .tabItem {
                    Label("Tâches", systemImage: "house")
                }

            // MARK: Onglet Ajouter
            NewTaskView(taskToAdd: $allTasks)
                .tabItem {
                    Label("Ajouter", systemImage: "plus.square")
                }

            // MARK: Onglet Coach
            AvatarView()
                .tabItem {
                    Label("Coach", systemImage: "pawprint")
                }

            // MARK: Onglet Profil
            PageProfilView()
                .tabItem {
                    Label("Profil", systemImage: "person.circle")
                }
        }
    }
}

// MARK: - Preview
#Preview {
    MainTabView()
}
