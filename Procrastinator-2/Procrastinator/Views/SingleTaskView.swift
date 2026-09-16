import SwiftUI

// MARK: - ToggleStyle: carré rempli (row cliquable)
struct CheckboxRowToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 12) {
            Image(
                systemName: configuration.isOn
                    ? "checkmark.square.fill" : "square"
            )
            .font(.title3)
            .foregroundStyle(configuration.isOn ? .green : .gray)

            configuration.label
                .foregroundStyle(.primary)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 2)
        .contentShape(Rectangle())  // ✅ toute la carte est tappable
        .onTapGesture {
            withAnimation(.snappy) { configuration.isOn.toggle() }
            #if canImport(UIKit)
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            #endif
        }
    }
}

// MARK: - Row d’un jalon
struct MilestoneRow: View {
    @Binding var milestone: TaskManager.SingleTask.Milestone

    private var isDone: Binding<Bool> {
        Binding(
            get: { milestone.status == 2 },
            set: { milestone.status = $0 ? 2 : 0 }
        )
    }

    var body: some View {
        Toggle(isOn: isDone) {
            VStack(alignment: .leading, spacing: 4) {
                Text(milestone.title)
                    .font(.body)
                    .fontWeight(.medium)
                    .strikethrough(isDone.wrappedValue)

                if let due = milestone.dueDate {
                    Text(due, style: .date)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }.padding(4)
        }
        
        .toggleStyle(CheckboxRowToggleStyle())
    }
}

// MARK: - Vue: fiche d'une tâche et ses infos clés
struct SingleTaskView: View {

    // MARK: - Données d'entrée (binding pour rendre les jalons modifiables)
    @Binding var task: TaskManager.SingleTask

    // MARK: - Navigation
    @Environment(\.dismiss) private var dismiss

    // MARK: - Popup tâche terminée
    @State private var showingPopup = false

    // MARK: - Texte d'encouragement selon la progression
    var encouragement: String {
        switch progress {
        case 0: return "Allez, il faut commencer 💪"
        case 0..<0.5: return "Bon début, continue ! 🚀"
        case 0.5..<1: return "Tu y es presque !!! ✨"
        case 1: return "Bravo, mission accomplie 🎉"
        default: return ""
        }
    }

    var body: some View {
        ScrollView {  // ✅ tout tient sur une page scrollable
            VStack(spacing: 12) {

                // MARK: Carte 1 — Titre, progression et message
                VStack(spacing: 8) {
                    Text(task.title)
                        .font(.title)

                    DiagramTaskProgress(progress: progress)

                    Text(encouragement).fontWeight(.bold)

                    if let detail = task.detail, !detail.isEmpty {  // ✅ sans force unwrap
                        Text(detail)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.04), radius: 6, x: 0, y: 2)

                // MARK: Carte 2 — Métadonnées (dates, priorité, rappel)
                VStack(spacing: 16) {
                    HStack {
                        Text("Date limite")
                        Spacer()
                        Text(task.dueDate.map(formattedDate) ?? "—")
                            .fontWeight(.bold)
                    }
                    Divider()
                    HStack {
                        Text("Priorité")
                        Spacer()
                        Text(priorityName(task.priority)).fontWeight(.bold)
                    }
                    Divider()

                    HStack {
                        Text("Rappel")
                        Spacer()
                        Text("29 septembre").fontWeight(.bold)  // TODO: vraie donnée
                    }
                }
                .padding()
                .background(.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.04), radius: 6, x: 0, y: 2)

                // MARK: Section — Liste des jalons
                VStack(alignment: .leading, spacing: 8) {
                    Text("À Faire")
                        .foregroundStyle(.primary)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.vertical, 4)

                    LazyVStack(spacing: 10) {
                        ForEach(task.milestones.indices, id: \.self) { i in
                            MilestoneRow(milestone: $task.milestones[i])
                               
                        }
                    }
                    .padding(.top, 4)

                    // MARK: Actions
                    Button("Terminer") {
                        withAnimation(.snappy) {
                            task.status = 2
                            showingPopup = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            showingPopup = false
                            dismiss()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 8)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
        }
        .background(.themeLight)  // garde ton thème global
        .fullScreenCover(isPresented: $showingPopup) {
            CongratulationView()
        }
    }

    // MARK: - Helpers

    /// Ratio de progression sur les jalons (0 à 1).
    var progress: Double {
        let total = task.milestones.count
        guard total > 0 else { return 0 }
        let done = task.milestones.filter { $0.status == 2 }.count
        return Double(done) / Double(total)
    }

    /// Formatte une date en français, sans année si c'est l'année courante.
    func formattedDate(_ date: Date) -> String {
        let cal = Calendar.current
        let yNow = cal.component(.year, from: .now)
        let y = cal.component(.year, from: date)
        let df = DateFormatter()
        df.locale = Locale(identifier: "fr_FR")
        df.dateFormat = (y == yNow) ? "d MMMM" : "d MMMM yyyy"
        return df.string(from: date)
    }

    /// Nom lisible d'une priorité à partir d'un entier.
    func priorityName(_ p: Int) -> String {
        switch p {
        case 0: return "Basse"
        case 1: return "Normale"
        case 2: return "Haute"
        case 3: return "Critique"
        default: return "—"
        }
    }
}

// MARK: - Preview
#Preview {
    SingleTaskView(
        task: .constant(
            TaskManager.SingleTask(
                title: "Préparer la présentation",
                detail: "Relire les slides et répéter 1×",
                dueDate: Date().addingTimeInterval(86400 * 2),
                category: 1,
                status: 1,
                priority: 2,
                milestones: [
                    .init(
                        title: "Rassembler les slides",
                        dueDate: nil,
                        status: 2
                    ),
                    .init(
                        title: "Nettoyer les graphiques",
                        dueDate: nil,
                        status: 1
                    ),
                    .init(
                        title: "Faire une répétition",
                        dueDate: nil,
                        status: 0
                    ),
                ]
            )
        )
    )
}
