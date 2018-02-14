class Category < ActiveRecord::Base
  has_many :questions
  has_many :game_categories
  has_many :games, through: :game_categories

  URL = "https://opentdb.com/api.php?amount=30&category="

  def self.establish_connection
    #MAYBE
    data_calls = []
    #category numbers in array
      data_calls << RestClient.get("#{URL}9&type=multiple")
      data_calls << RestClient.get("#{URL}22&type=multiple")
      data_calls << RestClient.get("#{URL}26&type=multiple")
      data_calls << RestClient.get("#{URL}23&type=multiple")
      data_calls << RestClient.get("#{URL}21&type=multiple")
      parsed_data = data_calls.map {|data| JSON.parse(data)['results']}
  end

  def self.save_categories
    category_names = ["General Knowledge", "Geography", "Celebrities", "History", "Sports" ]
    category_names.each do |name|
      category = Category.new(name: name)
      category.save
    end
  end

  def self.save_questions
    parsed_data = self.establish_connection
    # binding.pry
    #loop and increment the
    counter = 0
    table = {"&shy;" => "-",
      "&quot;" => "\"",
      "&#039;" => "\'",
      "&uuml;" => "u",
      "&ldquo;" => "\"",
      "&rdquo;" => "\"",
      "&rsquo;" => "'",
      "&hellip;" => "...",
      "&amp;" => "&",
      "&iacute;" => "i",
      "&oacute;" => "o",
      "&aacute;" => "a",
      "&deg;" => " degree(s)",
      "&prime;" => "\'",
      "&Prime;" => "\"",
			"&auml;" => "a",
			"&ouml;" => "o",
			"&aring;" => "a"}
    re = Regexp.new(table.keys.map {|x| Regexp.escape(x) }.join("|"))
    parsed_data.each do |category_array|
      counter += 1
      category_array.map do |question|
      # binding.pry

      question = Question.new(question: question["question"].gsub(re , table),
        category_id: counter,
        difficulty: question["difficulty"],
        correct_answer: question["correct_answer"].gsub(re , table),
        incorrect_answer1: question["incorrect_answers"][0].gsub(re , table),
        incorrect_answer2: question["incorrect_answers"][1].gsub(re , table),
        incorrect_answer3: question["incorrect_answers"][2].gsub(re , table)
      )
      # question.question.gsub!(re , table)
      question.save
      end

    end
  end

end
