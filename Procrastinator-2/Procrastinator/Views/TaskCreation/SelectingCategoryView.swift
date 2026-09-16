//
//  SelectingCategoryView.swift
//  Procrastinator
//
//  Created by Noémie De Meyer on 24/09/2025.
//


import SwiftUI

struct SelectingCategoryView: View {
    @Binding var selectedCategory: CategoriesSelection
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                
                ForEach(categoryArray) { category in
                    VStack {
                        ZStack {
                            
                            Button {
                                selectedCategory = category
                                
                            } label: {
                                
                                Circle()
                                    .foregroundStyle(selectedCategory == category ? category.buttonColorFill : .grayButton
                                    )
                                    .frame(width: 65, height: 65)
                                    .padding(5)
                                ZStack{
                                    
                                }
                            }
                            
                            Image(systemName: category.iconCategory)
                                .resizable()
                                .frame(width: 26, height: 26)
                                .foregroundStyle(selectedCategory == category ? category.iconColor :
                                        .black)
                            
                        }
                        Text(category.name)
                            .font(.footnote)
                    }
                }
               
            }
        }
        .scrollIndicators(.hidden)
    }
}


#Preview {
    SelectingCategoryView(selectedCategory: .constant(categoryArray[3]))
}
