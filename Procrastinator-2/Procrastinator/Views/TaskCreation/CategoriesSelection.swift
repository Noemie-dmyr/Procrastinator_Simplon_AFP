//
//  CategoriesSelection.swift
//  Procrastinator
//
//  Created by Noémie De Meyer on 19/09/2025.
//

import SwiftUI


struct CategoriesSelection: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var iconCategory: String
    var circleColorBorder: Color
    var buttonColorFill: Color
    var iconColor: Color
    var categoryInt: Int {
        switch name {
        case "École":
            return 3
        case "Travail":
            return 1
        case "Santé":
            return 0
        case "Ménage":
            return 5
        case "Budget":
            return 4
        case "Loisirs":
            return 2
        default :
            return 99
        }
    }
    // 0: Santé, 1: Travail, 2: Loisirs, 3: Études, 4: Budget, 5: Ménage
}

var categoryArray = [
    CategoriesSelection(
        name: "École",
        iconCategory: "graduationcap.fill",
        circleColorBorder: .blue,
        buttonColorFill: .paleBlueSchool,
        iconColor: .darkBlueSchool

    ),
    CategoriesSelection(
        name: "Travail",
        iconCategory: "suitcase.fill",
        circleColorBorder: .brown,
        buttonColorFill: .paleBrownWork,
        iconColor: .darkBrownWork
    ),
    CategoriesSelection(
        name: "Santé",
        iconCategory: "cross.fill",
        circleColorBorder: .pink,
        buttonColorFill: .palePinkHealth,
        iconColor: .darkPinkHealth
    ),
    CategoriesSelection(
        name: "Ménage",
        iconCategory: "bubbles.and.sparkles.fill",
        circleColorBorder: .mint,
        buttonColorFill: .paleBlueCleaning,
        iconColor: .darkBlueCleaning
    ),
    CategoriesSelection(
        name: "Budget",
        iconCategory: "eurosign",
        circleColorBorder: .green,
        buttonColorFill: .paleGreenBudget,
        iconColor: .darkGreenBudget
    ),
    CategoriesSelection(
        name: "Loisirs",
        iconCategory: "paintbrush.fill",
        circleColorBorder: .orange,
        buttonColorFill: .paleOrangeHobbies,
        iconColor: .darkOrangeHobbies
    ),
    CategoriesSelection(
        name: "Autres",
        iconCategory: "ellipsis.circle.fill",
        circleColorBorder: .orange,
        buttonColorFill: .paleFushiaOther,
        iconColor: .black
    ),
    
]
