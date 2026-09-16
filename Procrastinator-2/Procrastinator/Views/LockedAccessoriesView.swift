//
//  LockedAccessoriesView.swift
//  ProcrastinatorTest
//
//  Created by Emilie on 19/09/2025.
//

import SwiftUI

struct LockedAccessoriesView: View {
    var levelUser: Int
    var body: some View {

        ZStack {
            HStack {
                VStack {
                    Image(systemName: "lock.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 105, height: 50)
                        .foregroundStyle(.gray)
                        .padding(.all, 8)

                    Text("Débloquer")
                    Text("Niv \(levelUser)")

                        .padding(.bottom, 12)
                }
                VStack {
                    Image(systemName: "lock.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 105, height: 50)
                        .foregroundStyle(.gray)
                        .padding(.all, 8)

                    Text("Débloquer")
                    Text("Niv \(levelUser + 1)")
                        .padding(.bottom, 12)
                }
                VStack {
                    Image(systemName: "lock.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 105, height: 50)
                        .foregroundStyle(.gray)
                        .padding(.all, 8)

                    Text("Débloquer")
                    Text("Niv \(levelUser + 2)")
                        .padding(.bottom, 12)
                }
            }
            .background(.themeLight)
            .cornerRadius(16)
            .padding(.horizontal, 24)
        }
    }
}
