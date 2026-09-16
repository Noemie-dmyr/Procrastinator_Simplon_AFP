//
//  NewTaskCatTalkingHeaderView.swift
//  Procrastinator
//
//  Created by Noémie De Meyer on 24/09/2025.
//


import SwiftUI

struct NewTaskCatTalkingHeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                
                Spacer()
                
                //MARK: - IMAGE CHAT FIXE
                Image(.catMood3)
                    .resizable()
                    .cornerRadius(60)
                    .overlay(Circle().stroke())
                    .frame(width: 120, height: 120)
                    .foregroundStyle(.quaternary)
                
                Image(.catYouCanDoIt2)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 160)
                
                Spacer()
            }
        }
    }
}