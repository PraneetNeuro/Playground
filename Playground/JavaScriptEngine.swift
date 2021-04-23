//
//  JavaScriptEngine.swift
//  Playground
//
//  Created by Praneet S on 23/04/21.
//

import Foundation
import JavaScriptCore

class JSEngine {
    private var context: JSContext
    
    private init(){
        context = JSContext()
    }
    
    public var shared: JSEngine = JSEngine()
    
    public func run(source: String) -> JSValue {
        return context.evaluateScript(source)
    }
}
