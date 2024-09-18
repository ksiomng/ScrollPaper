//
//  ContentView.swift
//  ScrollPaper
//
//  Created by Song Kim on 9/12/24.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @State var arr: [String] = ["dsjfl", "djaflsdjfl", "spacing: 10"]
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: UIScreen.main.bounds.width * 0.02) {
                    ForEach(0..<arr.count, id: \.self) { i in
                        ZStack {
                            KFImage(URL (string: "https://lh4.googleusercontent.com/proxy/c-v0e5l7AIsDvGqELDtp3j1sWJgchFrVcJrG3DJrkFrieE-OECuOJob3CLdptPp6HfnSrUH3B9WIKQDPMjw1FV1rtVpt-x97EX7cHDcuvlCBqR1NuMS7qTYwbeN1ysuyJ74Dwgi4lvu3SsxSZc5Onw"))
                                .resizable()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            TextEditor(text: $arr[i])
                                .scrollContentBackground(.hidden)
                                .background(Color.clear)
                                .padding(20)
                        }
                        .frame(width: 355, height: 450)
                    }
                }
                .padding(.horizontal, UIScreen.main.bounds.width * 0.04)
            }
            .scrollTargetLayout()
            .scrollTargetBehavior(.viewAligned)
        }
    }
}

#Preview {
    ContentView()
}
