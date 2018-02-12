class Api < ActiveRecord::Base
    #works with data selection - talking to the api
    #passes to game class
    :has_many :games
    :has_many :users, through: :games

    # def category
    #     user_cat = gets.chomp
    #     if user_cat == 1
    #         9
    #     elsif user_cat == 2
    #         22
    #     user_cat
    #     end
    #     #user category selection
    #         #general Knowledge = 9
    #         #Geography = 22
    #         #Celebs = 26
    #         #History = 23
    #         #Sports = 21
 #
    # end

    def establish_connection
      questions_raw = RestClient.get("https://opentdb.com/api.php?amount=1&category=9")
      parsed_data = JSON.parse(questions_raw)['results']
    end

    def get_questions
        question = establish_connection[0]["question"]
        binding.pry
    end

    def get_possible_answers
        answers = []
        correct_answer = establish_connection[0]["correct_answer"]
        incorrect_answers = establish_connection[0]["incorrect_answers"]
        answers << incorrect_answers
        answers << correct_answer
        binding.pry
    end

end
