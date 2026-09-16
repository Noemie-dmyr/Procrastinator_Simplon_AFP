//
//  Avatar.swift
//  ProcrastinatorTest
//
//  Created by Emilie on 18/09/2025.
//

import SwiftUI

struct AvatarView: View {
    
   @State var hasGlasses : Bool = false
    @State var hasCap : Bool = false
    @State var hasBasket : Bool = false
   @State var stockCoins : Int = 16
    var accessoryPurchase : Bool = false
        
    var body: some View {
        
        ScrollView(.vertical) {
            
            VStack {
                
                Text("PROCRASTINATOR")
                    .font(.custom("SilkscreenRegular.ttf", size: 18))
//                    .font(.title2)
                    .padding(.bottom)
                
                
                ZStack(alignment: .bottom) {
                    
                    Image(.unhappyCat)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 400, alignment: .trailing)
                        .edgesIgnoringSafeArea(.trailing)
        
     // Pour que les accessoires s'affichent si utilisateurs les achètent.
                    if hasGlasses {
                        
                        Image(.accessoryGlasses)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 400)
                            .offset(x: 5)
                    }
                        if hasCap {
                            Image(.accessoryCap)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 400)
                    }
                    
                    if hasBasket {
                        
                        Image(.accessoryBasket)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 400)
                            .offset(y: 5)
                    }
                    
                    Text("NIVEAU 3")
                    
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(20)
                    
                    ZStack {
                        Capsule()
                            .stroke(lineWidth: 1)
                            .background(.white)
                            .cornerRadius(14)
                            .frame(width: 200.0, height: 30.0)
                            .foregroundStyle(.brown)
                            .offset(y: 15)
                        
                        Capsule()
                            .cornerRadius(14)
                            .frame(width: 50, height: 25.0)
                            .offset(x: -72, y: 15)
                            .foregroundStyle(.red)
                        Text("11%")
                            .offset(x: -72, y: 15)
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                    }
                }
                
                HStack {
                    Image(.coin)
                    Text("\(stockCoins) PIÈCES")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(10)
                }
                .padding(.top, 30)
                
                HStack {
                    VStack {
    // Bouton pour acheter les lunettes (retour pas fait, c'est normal).
                            Button(
                                action: {
                                    withAnimation(.bouncy(duration: 1)) {
                                        if stockCoins >= 5 && hasGlasses == false {
                                            hasGlasses = true
                                            stockCoins -= 5
                                        }
                                    }
                                }, label: {
                                    
                                    Image(systemName: "sunglasses")
                                        .resizable()
                                        .frame(width: 90, height: 40)
                                        .foregroundStyle(.catGlasses)
                                        .fontWeight(.bold)
                                        .padding(.all, 16)
                                }
                            )
                            HStack {
    // Si l'utilisateur n'a pas acheté l'accessoire, alors les 5 pièces s'affichent en dessous.
                                if hasGlasses == false {
                                Image(.coin)
                                
                                Text("5")
                                    .font(.title3)
                                    .fontWeight(.bold)
     // Si accessoire acheté, les 5 pièces sont remplacées par un check.
                                } else {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.green)
                                }
                                }
                            .padding(.bottom)
                            
                        }
                        
                    VStack {
    // Bouton pour acheter la casquette (retour pas fait, c'est normal).
                        Button(
                            action: {
                                withAnimation(.bouncy(duration: 1)) {
                                    if stockCoins >= 5 && hasCap == false {
                                        hasCap = true
                                        stockCoins -= 5
                                    }
                                }
                            }, label: {
                                
                                Image(systemName: "hat.cap.fill")
                                    .resizable()
                                    .frame(width: 90, height: 40)
                                    .foregroundStyle(.catCap)
                                    .padding(.all, 16)
                            }
                    )
                            HStack {
    // Si l'utilisateur n'a pas acheté l'accessoire, alors les 5 pièces s'affichent en dessous.
                                if hasCap == false {
                                Image(.coin)
                                Text("5")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    
    // Si accessoire acheté, les 5 pièces sont remplacées par un check.
                                } else {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.green)
                                }
                            }
                            .padding(.bottom)
                        }
                        VStack {
    // Bouton pour acheter la casquette (retour pas fait, c'est normal).
                            Button(
                                action: {
                                    withAnimation(.bouncy(duration: 1)) {
                                        if stockCoins >= 5 && hasBasket == false {
                                            hasBasket = true
                                            stockCoins -= 5
                                        }
                                    }
                                }, label: {
                                    
                                    Image(systemName: "shoe.fill")
                                        .resizable()
                                        .frame(width: 90, height: 40)
                                        .foregroundStyle(.catShoe)
                                        .padding(.all, 16)
                                }
                            )
                            
                            HStack {
    // Si l'utilisateur n'a pas acheté l'accessoire, alors les 5 pièces s'affichent en dessous.
                                if hasBasket == false {
                                Image(.coin)
                                Text("5")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    
    // Si accessoire acheté, les 5 pièces sont remplacées par un check.
                                } else {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.green)
                                }
                                }
                            .padding(.bottom)
                        }
                }
                    .background(.themeLight)
                    .cornerRadius(16)
                    .padding(16)
                    

// Extraction de la barre d'accessoires verrouillée
                    
                    LockedAccessoriesView(levelUser: 4)
                        .padding(16)
                    LockedAccessoriesView(levelUser: 7)
                        .padding(16)
                    LockedAccessoriesView(levelUser: 10)
                        .padding(16)
                    LockedAccessoriesView(levelUser: 13)
                        .padding(16)
                
            }
        }
    }
    
}
    #Preview {
        AvatarView()
    }
    
    
   
