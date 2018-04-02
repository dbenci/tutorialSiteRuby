class QuizController < ApplicationController
  def hiragana
    @title = 'Quiz Hiragana'

    questionAndAnswer = Array.new

    questionAndAnswer.push(readyHashMap("How do you write Hello World in an alert box?", 2, ['msg("Hello World");', 'alert("Hello World");', 'alertBox("Hello World");']))
    questionAndAnswer.push(readyHashMap("How do you create a function in JavaScript?", 3, ['function:myFunction()', 'function = myFunction()', 'function myFunction()']))
    questionAndAnswer.push(readyHashMap("How to write an IF statement in JavaScript?", 1, ['if (i == 5)', 'if i = 5 then', 'if i == 5 then']))
    questionAndAnswer.push(readyHashMap("How does a FOR loop start?", 2, ['for (i = 0; i <= 5)', 'for (i = 0; i <= 5; i++)', 'for i = 1 to 5']))
    questionAndAnswer.push(readyHashMap("What is the correct way to write a JavaScript array?", 3, ['var colors = "red", "green", "blue"', 'var colors = (1:"red", 2:"green", 3:"blue")', 'var colors = ["red", "green", "blue"]']))
    
    questionAndAnswerJson = questionAndAnswer.to_json

    p "check hash : #{questionAndAnswerJson}"


    @questionForFrontend = questionAndAnswerJson
   # H = Hash["a" => 100, "b" => 200]
   # p "check hash : #{H}"
    #choices = ['msg("Hello World");', 'alert("Hello World");', 'alertBox("Hello World");']
  end

  def readyHashMap(question, answer, choice)
    hashMap = ['Q' => question, 'A' => answer, 'C' => choice]
    return hashMap
  end

  def readyChoiceArray(choiceOne, choiceTwo, choiceTree)
    return [choiceOne, choiceTwo, choiceTree]
  end
end
