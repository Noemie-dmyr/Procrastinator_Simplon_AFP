//
//  SwiftUIView.swift
//  Procrastinator
//
//  Created by Noémie De Meyer on 18/09/2025.
//

import SwiftUI

// STRUCT ETAPE

struct NewTaskView: View {
    
    //    @Binding var exampleTasks: [TaskManager.SingleTask]
    
    @Binding var taskToAdd: [TaskManager.SingleTask]
    
    @State var userInput: String = ""
    @State var selectedDate = Date()
    @State var selectedItem: CategoriesSelection = categoryArray[6]
    
    // MARK: - PRIORITÉ
    @State var selectedPriority: PrioritySelection = priorityArray[2]
    
    // MARK: - ALERTE
    @State var selectedAlerte: String = "Aucune"
    let alertes = [
        "Aucune", "30 minutes avant", "1 heure avant", "1 jour avant",
    ]
    
    // MARK: - RÉCURRENCE
    @State var selectedRecurrence: String = "Jamais"
    let recurrences = [
        "Jamais", "Tous les jours", "Toutes les semaines", "Tous les mois",
    ]
    
    // MARK: - ÉTAPES
    @State var milestones: [TaskManager.SingleTask.Milestone] = []
    @State var stepTitle: String = ""
    
    // MARK: - NOTES
    @State var notes: String = ""
    
    //MARK: - POP UP
    @State var showConfirmation = false
    
    var body: some View {
        
        ScrollView(.vertical) {
            VStack {
                VStack {
                    
                    //MARK: - TITRE
                    Text("NOUVELLE TÂCHE")
                    
                        .padding()
                        .cornerRadius(16)
                        .fontWeight(.bold)
                        .foregroundStyle(.themeDarker)
                        .font(.title2)
                    
                }
                // MARK: - TALKING CAT
                
                NewTaskCatTalkingHeaderView()
                
                // MARK: - TEXTE MODIFIABLE
                VStack(alignment: .leading) {
                    
                    TextField("Ajouter un titre ...", text: $userInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 380, height: 60)
                    
                }
                
                //MARK: -  SELECTION CATEGORIE BOUTON
                
                SelectingCategoryView(selectedCategory: $selectedItem)
                
                
                //MARK: - CALENDRIER
                VStack(alignment: .leading) {
                    DatePicker(
                        "",
                        selection: $selectedDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(GraphicalDatePickerStyle())
                    
                    Text("Priorité")
                        .padding()
                        .foregroundStyle(.themeDarker)
                        .font(.title3)
                        .cornerRadius(8)
                        .fontWeight(.bold)
                        
                }
                
                //MARK: - PRIORITÉ BOUTON
                HStack {
                    ForEach(priorityArray) { prioritySelection in
                        VStack{
                            ZStack {
                                
                                Button {
                                    selectedPriority = prioritySelection
                                    
                                } label: {
                                    
                                    Circle()
                                        .foregroundStyle(
                                            selectedPriority == prioritySelection
                                            ? prioritySelection.buttonColorFillprio
                                            : prioritySelection.buttonColorEmptyprio
                                        )
                                        .frame(width: 65, height: 65)
                                        .overlay(
                                                Circle()
                                                    .strokeBorder(prioritySelection.circleColorBorderprio, lineWidth: 2)
                                                )
                                        .padding(8)
                                    
                                    
                                }
                                
                                Text(prioritySelection.name)
                                    .foregroundStyle(.black)
                                    .font(.title3)
                                
                                
                            }
                            Text(prioritySelection.descriptionPriority)
                                .font(.footnote)
                                .padding(.bottom)
                                .foregroundStyle(.themeDarker)
                        }
                    }
                }
                // MARK: - PICKER ALERTE 
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        
                        Text("Alerte")
                            .font(.headline)
                            .padding()
                        
                        Spacer()
                        
                        Picker("Alerte", selection: $selectedAlerte) {
                            ForEach(alertes, id: \.self) { alerte in
                                Text(alerte).tag(alerte)
                            }
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(lineWidth: 2)
                            .foregroundStyle(.themeDark.opacity(0.5))
                        
                        
                    ).padding(.horizontal)
                }
                
                // MARK: - PICKER RECURRENCE
                HStack {
                    
                    Text("Récurrence")
                        .font(.headline)
                        .padding()
                    
                    Spacer()
                    
                    Picker("Récurrence", selection: $selectedRecurrence) {
                        ForEach(recurrences, id: \.self) { recurrence in
                            Text(recurrence).tag(recurrence)
                        }
                    }
                }
                .pickerStyle(.menu)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(lineWidth: 2)
                        .foregroundStyle(.themeDark.opacity(0.5))
                    
                ) .padding(.horizontal)
                
                //MARK: -  TITRE ETAPES
                VStack(alignment: .leading, spacing: 8) {
                    Text("Étapes")
                        .font(.headline)
                    
                    // MARK: - LISTE ETAPE (VALIDATION ET DESTRUCTION)
                    ForEach(milestones.indices, id: \.self) { index in
                        HStack {
                            TextField(
                                "Étape \(index + 1)",
                                text: $milestones[index].title
                            )
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            Button(role: .destructive) {
                                milestones.remove(at: index)
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                            
                        }
                    }
                    
                    Spacer()
                    
                    // MARK: - AJOUT NOUVELLE ETAPE
                    HStack {
                        TextField("Ajouter une étape ...", text: $stepTitle)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button {
                            if !stepTitle.isEmpty {
                                milestones.append(
                                    TaskManager.SingleTask.Milestone(
                                        title: stepTitle,
                                        dueDate: selectedDate,
                                        status: 0
                                    )
                                )
                                stepTitle = ""
                            }
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundColor(.blue)
                        }
                    }
                    
                }
                
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(lineWidth: 2)
                        .foregroundStyle(.themeDark.opacity(0.5))
                    
                ).padding(.horizontal)
                
                
                // MARK: - NOTES
                
                VStack(alignment: .leading) {
                    
                    Text("Notes")
                        .font(.headline)
                    
                    TextEditor(text: $notes)
                            .frame(minHeight: 70)
                            .padding(4)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .strokeBorder(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(lineWidth: 2)
                        .foregroundStyle(.themeDark.opacity(0.5))
                    
                )
                .padding(.horizontal)
                Spacer(minLength: 40)
                
                // MARK: - BOUTON VALIDATION
                Button {
                    taskToAdd.append(
                        TaskManager.SingleTask(
                            title: userInput,
                            detail: notes,
                            dueDate: selectedDate,
                            category: selectedItem.categoryInt,
                            priority: selectedPriority.priorityInt,
                            milestones: milestones
                        )
                    )
                    userInput = ""
                    notes = ""
                    selectedDate = Date()
                    selectedItem = categoryArray[6]
                    selectedPriority = priorityArray[2]
                    selectedAlerte = "Aucune"
                    selectedRecurrence = "Jamais"
                    milestones = []
                    stepTitle = ""
                    
                    //MARK: - POP UP VALIDATION
                    showConfirmation = true
                    
                } label: {
                    Text("Ajouter la tache")
                        .background(.grayButton)
                        .cornerRadius(8)
                        .font(.title3)
                    
                }
                .disabled(userInput.isEmpty)
                .alert("✅", isPresented: $showConfirmation) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text("Ta nouvelle tâche a bien été enregistrée !")
                }
                
                .padding()
                .background(.grayButton)
                .cornerRadius(8)
            }
        }
        .scrollIndicators(.hidden)
//        .padding()
        
        //MARK: - FIN SCROLLVIEW VERTICALE
    }
    
}

#Preview {
    NewTaskView(taskToAdd: .constant([]))
}

