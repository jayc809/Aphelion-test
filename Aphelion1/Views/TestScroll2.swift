//
//  ScrollTest2.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/9.
//

import SwiftUI

// Data model
struct Item: Identifiable {
    let id = UUID()
    var value: Int
    var loc: CGRect = .zero
}

struct TestScroll2: View {
    
    @State var ruler: CGFloat!
    @State var items = (0..<10).map { Item(value: $0) }
    @State var centredItem: Item!
    let selectedMultiplier: CGFloat = 1.5
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                        ZStack {
                            Image("PauseMenu")
                                .resizable()
                        }
                        .frame(
                            width: centredItem != nil && centredItem.id == item.id ? Constants.screenWidth * 0.35 * selectedMultiplier : Constants.screenWidth * 0.35,
                            height: centredItem != nil && centredItem.id == item.id ? 50 * selectedMultiplier : 50
                        )
                        .id(index)
                        .padding(10)
                        .measureLoc { loc in
                            
                            items[index].loc = loc
                            
                            if let ruler = ruler {
                                
                                if item.loc.maxY >= ruler && item.loc.minY <= ruler {
                                    withAnimation(.easeOut(duration: 0.1)) {
                                        centredItem = item
                                        //proxy.scrollTo(index, anchor: .center)
                                    }
                                }
                                
                                // Move outsides
                                if items.first!.loc.minY > ruler || items.last!.loc.maxY < ruler {
                                    withAnimation(.easeOut) {
                                        centredItem = nil
                                    }
                                }
                            }
                        }
                        .rotationEffect(Angle(degrees: -15))
                    }
                }
                // Extra space above and below
                .padding(.vertical, ruler)
            }
            .frame(width: Constants.screenWidth, height: Constants.screenHeight * 1.4)
            .measureLoc { loc in
                //finds center of screen using geometry reader
                ruler = (loc.minY + loc.maxY) / 2
            }
        }
        .rotationEffect(Angle(degrees: 15))
    }
}

struct LocKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {}
}

extension View {
    func measureLoc(_ perform: @escaping (CGRect) ->()) -> some View {
        overlay(GeometryReader { geo in
            Color.clear
                .preference(key: LocKey.self, value: geo.frame(in: .global))
        }.onPreferenceChange(LocKey.self, perform: perform))
    }
}

struct ScrollTest2_Previews: PreviewProvider {
    static var previews: some View {
        TestScroll2()
    }
}
