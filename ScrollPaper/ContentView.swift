//
//  ContentView.swift
//  ScrollPaper
//
//  Created by Song Kim on 9/12/24.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @State var textArr: [String] = [""]
    @State var heightArr: [CGFloat] = [0]
    @State var width: CGFloat = 0
    @State var isButton: Bool = false
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: UIScreen.main.bounds.width * 0.04) {
                    ForEach(0..<textArr.count, id: \.self) { i in
                        ZStack {
                            KFImage(URL(string: "https://lh4.googleusercontent.com/proxy/c-v0e5l7AIsDvGqELDtp3j1sWJgchFrVcJrG3DJrkFrieE-OECuOJob3CLdptPp6HfnSrUH3B9WIKQDPMjw1FV1rtVpt-x97EX7cHDcuvlCBqR1NuMS7qTYwbeN1ysuyJ74Dwgi4lvu3SsxSZc5Onw"))
                                .resizable()
                            
                            GeometryReader { geo in
                                VStack {
                                    CustomTextEditor(text: $textArr[i], height: $heightArr[i], width: $width, maxHeight: geo.size.height, maxWidth: geo.size.width)
                                        .frame(width: geo.size.width, height: geo.size.height)
                                        .border(Color.gray, width: 1)
                                        .onChange(of: heightArr[i]) {
                                            if heightArr[i] >= geo.size.height - 20 {
                                                isButton = true
                                            }
                                        }
                                }
                            }
                            .padding(UIScreen.main.bounds.width * 0.1)
                            
                            if isButton {
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            textArr.append("")
                                            heightArr.append(0)
                                            isButton = false
                                        }) {
                                            Text("+")
                                                .font(.title)
                                                .frame(width: 50, height: 50)
                                                .background(Color.blue)
                                                .foregroundColor(.white)
                                                .clipShape(Circle())
                                        }
                                        .padding()
                                    }
                                }
                            }
                        }
                        .id(i)
                        .aspectRatio(9/13, contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.88)
                    }
                }
                .scrollTargetLayout()
                .padding(.horizontal, UIScreen.main.bounds.width * 0.06)
            }
            .scrollTargetBehavior(.viewAligned)
        }
    }
}


#Preview {
    ContentView()
}

struct CustomTextEditor: UIViewRepresentable {
    @Binding var text: String
    @Binding var height: CGFloat
    @Binding var width: CGFloat
    var maxHeight: CGFloat
    var maxWidth: CGFloat
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: CustomTextEditor
        
        init(_ parent: CustomTextEditor) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            
            let size = textView.sizeThatFits(CGSize(width: parent.maxWidth, height: CGFloat.greatestFiniteMagnitude))
            
            DispatchQueue.main.async {
                self.parent.height = size.height
                self.parent.width = size.width
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 15)
        
        let maxWidthConstraint = NSLayoutConstraint(item: textView,
                                                    attribute: .width,
                                                    relatedBy: .lessThanOrEqual,
                                                    toItem: nil,
                                                    attribute: .notAnAttribute,
                                                    multiplier: 1.0,
                                                    constant: maxWidth)
        
        textView.addConstraint(maxWidthConstraint)
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text == text {
            return
        }
        uiView.text = text
    }
}
