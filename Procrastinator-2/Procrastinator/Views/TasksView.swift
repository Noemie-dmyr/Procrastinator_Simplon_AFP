//
//  TasksView.swift
//  Procrastinator
//
//  Created by apprenant112 on 17/09/2025.
//

// MARK: - Imports
import Charts
import SwiftUI

// MARK: - Utilitaires (global)

func overallCompletionRate(for tasks: [TaskManager.SingleTask]) -> Double {
    let relevant = tasks.filter { task in
        if task.dueDate != nil { return true }
        return task.status != 2  // garder les "sans date" seulement si pas terminées
    }

    let done = relevant.filter { $0.status == 2 }.count
    let total = relevant.count

    guard total > 0 else { return 0 }
    return Double(done) / Double(total)
}

// MARK: - TasksView
struct TasksView: View {
    // MARK: Data
    @State private var showingPopup = false

    /// Données (binding depuis le parent)
    @Binding var exampleTasks: [TaskManager.SingleTask]

    /// Progrès global des tâches (toutes confondues)
    private var overallProgress: Double {
        overallCompletionRate(for: exampleTasks)
    }

    var body: some View {
        // MARK: Navigation
        NavigationStack {

            // MARK: Scroll Content
            ScrollView(.vertical) {

                VStack(alignment: .leading) {
                    // MARK: Header
                    VStack(alignment: .leading) {
                        Spacer()
                        Image(.catTasksView)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)

                        ZStack {
                            RoundedRectangle(cornerRadius: 0)
                                .strokeBorder(lineWidth: 3)
                                .background(.themeLighter)
                                .padding(.top, -11)
                                .frame(height: 140)
                                .foregroundStyle(.themeLight)

                            Image(.catPawTasksView)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                                .offset(y: -78)

                            HStack {
                                Spacer()
                                Text("T'as pas l'impression de m'avoir zappé ?")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.themeDarker)
                                    .padding()

                                // Progrès global dynamique
                                DiagramTaskProgress(progress: overallProgress)

                                Spacer()
                            }
                            .padding(.bottom, 16)
                        }
                    }

                    // MARK: Sections by Category
                    if exampleTasks.isEmpty {
                        Text("FÉLICITATIONS !")
                    } else {
                        ListTasksByCategory(category: -1, tasks: $exampleTasks)  // À venir
                        ListTasksByCategory(category: 0, tasks: $exampleTasks)  // Santé
                        ListTasksByCategory(category: 1, tasks: $exampleTasks)  // Travail
                        ListTasksByCategory(category: 2, tasks: $exampleTasks)  // Loisirs
                        ListTasksByCategory(category: 3, tasks: $exampleTasks)  // Études
                        ListTasksByCategory(category: 4, tasks: $exampleTasks)  // Budget
                        ListTasksByCategory(category: 5, tasks: $exampleTasks)  // Ménage
                        ListTasksByCategory(category: 6, tasks: $exampleTasks)  // Autres
                    }
                }
            }
        }
        .safeAreaInset(edge: .bottom, alignment: .trailing) {
            if !showingPopup {  // le bouton n’existe plus après le clic
                Button {
                    showingPopup = true
                } label: {
                    Image(systemName: "dice")
                        .resizable()
                        .padding(16)
                        .font(.title)
                        .foregroundStyle(.white)
                        .frame(width: 60, height: 60)
                        .background(.themeDarker)
                        .clipShape(Circle())
                        .shadow(radius: 4, y: 2)
                        .padding()
                }
            }
        }

        .fullScreenCover(isPresented: $showingPopup) {
            TheWheelView()
        }
    }
}

// MARK: - Preview
#Preview {
    TasksView(exampleTasks: .constant(sampleTasks))
}

// MARK: - CardView
struct CardView: View {
    // MARK: Inputs
    @State var cardTitle: String
    @State var category: Int
    @State var dueDate: Date?
    var singleTask: TaskManager.SingleTask

    // MARK: Colors
    // 0: Santé, 1: Travail, 2: Loisirs, 3: Études, 4: Budget, 5: Ménage
    var lightColor: Color {
        switch category {
        case 0: return .palePinkHealth
        case 1: return .paleBrownWork
        case 2: return .paleOrangeHobbies
        case 3: return .paleBlueSchool
        case 4: return .paleGreenBudget
        case 5: return .paleBlueCleaning
        default: return .paleFushiaOther
        }
    }

    var darkColor: Color {
        switch category {
        case 0: return .mediumPinkHealth
        case 1: return .mediumBrownWork
        case 2: return .mediumOrangeHobbies
        case 3: return .mediumBlueSchool
        case 4: return .mediumGreenBudget
        case 5: return .mediumBlueCleaning
        default: return .mediumFushiaOther
        }
    }

    // MARK: Icon
    var categoryIcon: String {
        switch category {
        case 0: return "cross"
        case 1: return "suitcase"
        case 2: return "paintbrush"
        case 3: return "graduationcap"
        case 4: return "eurosign"
        case 5: return "bubbles.and.sparkles"
        default: return "ellipsis.circle"
        }
    }

    // MARK: Body
    var body: some View {
        VStack(alignment: .leading) {
            // MARK: Title & Due Date
            HStack {
                Text(cardTitle)
                    .fontWeight(.bold)
                    .lineLimit(2)

                Spacer()
                if let date = dueDate {
                    Text(formattedDate(date))
                        .font(.headline)
                }
            }

            // MARK: Milestones (max 2 + “+ x tâches”)
            let ms = singleTask.milestones
            VStack(alignment: .leading, spacing: 4) {
                ForEach(Array(ms.prefix(2).enumerated()), id: \.offset) {
                    _,
                    m in
                    Text("- \(m.title)")
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                if ms.count > 2 {
                    Text("+ \(ms.count - 2) tâches")
                        .font(.subheadline)
                }
            }
            .padding(.top, 4)

        }
        .foregroundStyle(.black)
        .background {
            Image(systemName: categoryIcon)
                .font(.system(size: 250))
                .foregroundStyle(darkColor)
                .offset(x: -110, y: 60)
                .rotationEffect(.degrees(12))
        }
        .padding()
        .frame(width: 300, height: 150)
        .background(lightColor)
        .cornerRadius(16)
        .padding(.leading, 8)
        .padding(.bottom, 4)
    }

    // MARK: Helpers
    func formattedDate(_ date: Date) -> String {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        let year = calendar.component(.year, from: date)

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = (year == currentYear) ? "d/MM" : "d/MM/yy"

        return formatter.string(from: date)
    }

    func categoryName(_ category: Int) -> String {
        switch category {
        case 0: return "Santé"
        case 1: return "Travail"
        case 2: return "Loisirs"
        case 3: return "Etudes"
        case 4: return "Budget"
        case 5: return "Ménage"
        default: return "Autres"
        }
    }
}
