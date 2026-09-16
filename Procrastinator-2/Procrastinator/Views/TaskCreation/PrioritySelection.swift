//
//  PrioritySelection.swift
//  Procrastinator
//
//  Created by Noémie De Meyer on 19/09/2025.
//
import SwiftUI

struct PrioritySelection: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var descriptionPriority: String
    var circleColorBorderprio: Color
    var buttonColorFillprio: Color
    var buttonColorEmptyprio: Color
    var priorityInt: Int {
        switch name {
        case "1":
            return 3
        case "2":
            return 2
        case "3":
            return 1
        case "4":
            return 0
        default:
            return 99
        }
    }

}

var priorityArray = [
    PrioritySelection(
        name: "1",
        descriptionPriority: "Urgent",
        circleColorBorderprio: .priorityOne,
        buttonColorFillprio: .priorityOne,
        buttonColorEmptyprio: .mediumPinkHealth
    ),
    PrioritySelection(
        name: "2",
        descriptionPriority: "Important",
        circleColorBorderprio: .priorityTwo,
        buttonColorFillprio: .priorityTwo,
        buttonColorEmptyprio: .mediumBrownWork
    ),
    PrioritySelection(
        name: "3",
        descriptionPriority: "Normal",
        circleColorBorderprio: .priorityThree,
        buttonColorFillprio: .priorityThree,
        buttonColorEmptyprio: .mediumOrangeHobbies
    ),
    PrioritySelection(
        name: "4",
        descriptionPriority: "Faible",
        circleColorBorderprio: .priorityFour,
        buttonColorFillprio: .priorityFour,
        buttonColorEmptyprio: .mediumGreenBudget
    ),

]

//var priority: Int = 1  // 0: Basse, 1: Normale, 2: Haute, 3: Critique
