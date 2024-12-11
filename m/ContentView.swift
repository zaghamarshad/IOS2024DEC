//
//  ContentView.swift
//  m
//
//  Created by Zagham Arshad on 2024-12-04.
//


import SwiftUI

struct ContentView: View {
    @State private var selectedAnswer: String? = nil
    let question = "Alex wants to install an application that is not available in the Apple App Store or any official Apple source on an Apple iPhone. What process would allow Alex to install the otherwise unsupported application?"
    let options = ["TTP", "MTTP", "Jailbreaking", "Repo hacking"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Header
            Text("Today's Question of the Day")
                .font(.headline)
                .padding(.top, 20)
            
            // Question
            Text(question)
                .font(.body)
                .multilineTextAlignment(.leading)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
            
            // Answer Options
            VStack(spacing: 10) {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selectedAnswer = option
                        // Handle the answer submission
                    }) {
                        Text(option)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(selectedAnswer == option ? Color.blue : Color(UIColor.systemGray6))
                            .foregroundColor(selectedAnswer == option ? .white : .black)
                            .cornerRadius(8)
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Footer
            HStack {
                Button(action: {
                    // Bookmark action
                }) {
                    Image(systemName: "bookmark")
                }
                Spacer()
                Button(action: {
                    // Share action
                }) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
            .padding()
        }
        .padding()
    }
}

struct QuestionScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


