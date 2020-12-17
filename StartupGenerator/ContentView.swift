//
//  ContentView.swift
//  StartupGenerator
//
//  Created by Andreea Almajan on 12.12.20.
//

import SwiftUI

/// Displays a big text.
struct BigTextView: View {
    private let content: String
    
    init(content: String) {
        self.content = content
    }
    
    var body: some View {
        Text(content)
            .font(Font.custom("Minion Regular", size: 55))
            .padding(40)
    }
}

/// Displays a centered button as an image (100x100) and a text underneath it.
struct ImageTextButtonView: View {
    private let imageName: String
    private let text: String
    private let action: () -> Void
    
    init(imageName: String, text: String, action: @escaping () -> Void) {
        self.imageName = imageName
        self.text = text
        self.action = action
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Button(action: action) {
                VStack {
                    Image(imageName).resizable().frame(width: 100, height: 100)
                }
            }
            Text(text)
                .font(.body).padding(20)
        }
    }
}

/// Displays the current  idea as well as a refresh button to get the next one.
struct IdeaView: View {
    
    private let idea: String;
    private let action: () -> Void
    
    init(idea: String, action: @escaping () -> Void) {
        self.idea = idea
        self.action = action
    }
    
    var body: some View {

        // The GeometryReader has access to the size of the screen.
        GeometryReader { geometry in
            
            let width = geometry.size.width;
            let height = geometry.size.height;
            
            // Have a vertical stack where 70% of the screen height is occupied by the idea and the bottom rest is allocated to the refresh button.
            VStack{
                BigTextView(content: idea)
                    .frame(width: width, height: height * 0.7, alignment: .center)
                    .onAppear(perform: action)
                ImageTextButtonView(imageName: "fire", text: "Burn to get the next idea.", action: action)
                    .frame(width: width, height: height * 0.2, alignment: .center)
                Spacer()
            }
        }
    }
}

/// Displays the content of the app.
struct ContentView: View {
    // The model our single source of truth.
    @StateObject var model = StartupIdeaViewModel()

    var body: some View {
        IdeaView(idea: model.ideaDescription, action: model.fetchIdea)
    }
}

/// Debug code for displaying the preview.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // You can change this string to whaterver you like to test it in the preview.
            IdeaView(idea: "It's like this for that.", action: {
                // Don't do much, this is a dummy.
            })
        }
    }
}
