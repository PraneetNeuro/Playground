//
//  ContentView.swift
//  Playground
//
//  Created by Praneet S on 23/04/21.
//

import SwiftUI
import CodeViewer
import JavaScriptCore

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
    var jsEngine: JSEngine = JSEngine.shared
    var body: some View {
        HStack {
            List {
                Button(action: {
                    print(jsEngine.run(source: jsCode))
                }, label: {
                    Label("Run", systemImage: "play.fill")
                })
            }
            .frame(width: 200)
            .listStyle(InsetGroupedListStyle())
            EditorView(jsCode: $jsCode)
        }
    }
}
