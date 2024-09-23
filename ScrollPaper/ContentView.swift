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
    @State var heightArr: [CGFloat] = []
    @State var widthArr: [CGFloat] = []
    
    @State private var text = ""
    @State private var height: CGFloat = 50
    @State private var width: CGFloat = 300
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        VStack {
            Text("Height: \(height)")
            Text("Width: \(width)")
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: UIScreen.main.bounds.width * 0.04) {
                    ForEach(0..<textArr.count, id: \.self) { i in
                        ZStack {
                            KFImage(URL (string: "https://lh4.googleusercontent.com/proxy/c-v0e5l7AIsDvGqELDtp3j1sWJgchFrVcJrG3DJrkFrieE-OECuOJob3CLdptPp6HfnSrUH3B9WIKQDPMjw1FV1rtVpt-x97EX7cHDcuvlCBqR1NuMS7qTYwbeN1ysuyJ74Dwgi4lvu3SsxSZc5Onw"))
                                .resizable()
                            VStack {
                                GeometryReader { geo in
                                    CustomTextEditor(text: $text, height: $height, width: $width, maxHeight: geo.size.height, maxWidth: geo.size.width)
                                        .frame(width: width, height: height)
                                        .border(Color.gray, width: 1)
                                }
                                
                                Spacer()
                            }
                            .padding(UIScreen.main.bounds.width * 0.1)
                        }
                        .aspectRatio(9/13, contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.88)
                    }
                }
                .padding(.horizontal, UIScreen.main.bounds.width * 0.06)
            }
            .scrollTargetLayout()
            .scrollTargetBehavior(.viewAligned)
        }
    }
    
    func setTextArr() {
        for i in 0..<textArr.count {
            if heightArr[i] > 50 {
                
            }
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
                self.parent.height = min(size.height, self.parent.maxHeight)
                self.parent.width = min(size.width, self.parent.maxWidth)
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
        uiView.text = text
    }
}

