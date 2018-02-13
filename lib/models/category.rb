class Category < ActiveRecord::Base

  def self.establish_connection
    #MAYBE
    data_calls = []
      data_calls << RestClient.get("https://opentdb.com/api.php?amount=10&category=9&type=multiple")
      data_calls << RestClient.get("https://opentdb.com/api.php?amount=10&category=22&type=multiple")
      data_calls << RestClient.get("https://opentdb.com/api.php?amount=10&category=26&type=multiple")
      data_calls << RestClient.get("https://opentdb.com/api.php?amount=10&category=23&type=multiple")
      data_calls << RestClient.get("https://opentdb.com/api.php?amount=10&category=21&type=multiple")
      parsed_data = data_calls.map {|data| JSON.parse(data)['results']}

      binding.pry
    questions = parsed_data.map do |row|
      c = Category.new
      c.question = row["question"]
    end
  end

  # def self.save_categories_and_questions
  #   parsed_data = self.establish_connection
  #   parsed_data[0].map {|question|
  #     Question.new(difficulty: question["difficulty"]
  #       correct_answer: question["correct_answer"])}
  #     end
  #
  # end

end
