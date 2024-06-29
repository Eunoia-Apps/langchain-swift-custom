//
//  File.swift
//  
//
//  Created by 顾艳华 on 12/25/23.
//

import Foundation
import GoogleGenerativeAI

public class Gemini: LLM {
    override func _send(text: String, stops: [String]) async throws -> LLMResult {
        let env = LC.loadEnv()
        
        if let apiKey = env["GOOGLEAI_API_KEY"] {
            let model = GenerativeModel(name: "gemini-1.0-pro-latest", apiKey: apiKey, safetySettings: [
        
        SafetySetting(harmCategory: .dangerousContent, threshold: .blockNone),
        SafetySetting(harmCategory: .harassment, threshold: .blockNone),
        SafetySetting(harmCategory: .hateSpeech, threshold: .blockNone),
        SafetySetting(harmCategory: .sexuallyExplicit, threshold: .blockNone),
        
    ])
            let response = try await model.generateContent(text)
            return LLMResult(llm_output: response.text)
        } else {
            print("Please set googleai api key.")
            return LLMResult(llm_output: "Please set googleai api key.")
        }
    }
}
