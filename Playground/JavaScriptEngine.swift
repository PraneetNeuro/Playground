//
//  JavaScriptEngine.swift
//  Playground
//
//  Created by Praneet S on 23/04/21.
//

import Foundation
import JavaScriptCore

class JSEngine: ObservableObject {
    private var context: JSContext
    @Published var results: [String] = []
    private init(){
        context = JSContext()
        let logHandler: @convention(block) (String) -> Void = { [self] string in
            results.append(string)
        }
        context.setObject(logHandler, forKeyedSubscript: "log" as (NSCopying & NSObjectProtocol)?)
    }
    
    public static var shared: JSEngine = JSEngine()
    
    public func run(source: String) {
        results = []
        let result = context.evaluateScript(source)!
        results.append("Value returned from script: \(result)")
    }
}
