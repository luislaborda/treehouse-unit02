//
//  Questions.swift
//  EnhanceQuizStarter
//
//  Created by Luis Laborda on 4/7/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

struct QuestionsProvider {
    
    // Data model for the game
    let questions: [Question] = [
        Question(question: "This was the only US President to serve more than two consecutive terms.",
                 possibleAnswers: ["George Washington", "Franklin D. Roosevelt","Woodrow Wilson","Andrew Jackson"],
                 answser: "Franklin D. Roosevelt"),
        Question(question: "Which of the following countries has the most residents?",
                 possibleAnswers: ["Nigeria", "Russia","Vietnam","Iran"],
                 answser: "Nigeria"),
        Question(question: "In what year was the United Nations founded?",
                 possibleAnswers: ["1918", "1919","1945","1954"],
                 answser: "1945"),
        Question(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?",
                 possibleAnswers: ["Paris", "Washington D.C.","New York City","Boston"],
                 answser: "New York City"),
        Question(question: "Which country has most recently won consecutive World Cups in Soccer?",
                 possibleAnswers: ["Italy", "Brazil","Argentina","Spain"],
                 answser: "Brazil"),
        Question(question: "Which of the following rivers is longest?",
                 possibleAnswers: ["Yangtze", "Mississippi","Congo","Mekong"],
                 answser: "Mississippi"),
        Question(question: "Which city is the oldest?",
                 possibleAnswers: ["Mexico City", "Cape Town","San Juan","Sydney"],
                 answser: "Mexico City"),
        Question(question: "Which country was the first to allow women to vote in national elections?",
                 possibleAnswers: ["Poland", "United States","Sweden","Senegal"],
                 answser: "Poland"),
        Question(question: "Which of these countries won the most medals in the 2012 Summer Games?",
                 possibleAnswers: ["France", "Germany","Japan","Great Britian"],
                 answser: "Great Britian")
    ]
}
