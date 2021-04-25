//
//  ContentView.swift
//  Playground
//
//  Created by Praneet S on 23/04/21.
//

import SwiftUI
import CodeViewer
import JavaScriptCore

struct ConsoleView: View {
    @Binding var result: [String]
    @Binding var height: CGFloat
    var body: some View {
        ScrollView {
            HStack {
                VStack(alignment: .leading) {
                    ForEach(result, id: \.self){ partialResult in
                        Text(partialResult)
                    }
                }
                .padding()
                Spacer()
            }
        }.background(Color.init(.systemGray5))
        .frame(height: height)
    }
}

struct EditorView: View {
    @Binding var jsCode: String
    @Binding var isResultShown: Bool
    var body: some View {
        CodeViewer(content: $jsCode, mode: .javascript, darkTheme: .dracula, lightTheme: .clouds, isReadOnly: false, fontSize: 16)
        .onTapGesture {
            isResultShown = false
        }
    }
}

struct ContentView: View {
    @State var jsCode: String = ""
    @State var isResultShown: Bool = false
    @State var resultViewHeight: CGFloat = CGFloat(250)
    @ObservedObject var jsEngine: JSEngine = JSEngine.shared
    var body: some View {
        NavigationView {
            List {
                Button(action: {
                    jsEngine.run(source: jsCode)
                    isResultShown = true
                }, label: {
                    Label("Run", systemImage: "play.fill")
                })
            }
            .listStyle(SidebarListStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            VStack {
                EditorView(jsCode: $jsCode, isResultShown: $isResultShown)
                if isResultShown {
                    ConsoleView(result: $jsEngine.results, height: $resultViewHeight)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    self.resultViewHeight += -gesture.translation.height
                                }
                        )
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
}
