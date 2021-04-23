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
    @Binding var result: String
    var body: some View {
        HStack{
            VStack {
                Text(result)
            }.frame(height: 250)
            Spacer()
        }
    }
}

struct EditorView: View {
    @Binding var jsCode: String
    var body: some View {
        CodeViewer(content: $jsCode, mode: .javascript, darkTheme: .dracula, lightTheme: .clouds, isReadOnly: false, fontSize: 16, textDidChanged: { source in
            print(source)
        })
    }
}

struct ContentView: View {
    @State var jsCode: String = ""
    @State var result: String = ""
    @State var isResultShown: Bool = false
    var jsEngine: JSEngine = JSEngine.shared
    var body: some View {
        HStack {
            List {
                Button(action: {
                    result = "\(jsEngine.run(source: jsCode))"
                    isResultShown = true
                }, label: {
                    Label("Run", systemImage: "play.fill")
                })
            }
            .frame(width: 200)
            .listStyle(InsetGroupedListStyle())
            VStack {
                EditorView(jsCode: $jsCode)
                if isResultShown {
                    ConsoleView(result: $result)
                }
            }
        }
    }
}
