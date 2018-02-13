class Game < ActiveRecord::Base
  #controller
  #join table
  #initiate the game
  #call on api
  #pass on user input
  #scores are kept for user
  has_many :game_categories
  has_many :categories, through: :game_categories
  belongs_to :user


  def start_game
    welcome
    find_or_create_username
    how_to_play
    show_categories
    randomize_questions
  end

  def sleeper
    sleep(0)
  end

  def welcome
    puts "Welcome to our game, please enter your name"
    sleeper
  end

  def find_or_create_username
    user_name = gets.chomp.downcase
    sleeper
    if user_name == nil || user_name == ""
      puts "Invalid entry, please enter your name"
      find_or_create_username
    else
      user = User.find_or_create_by(name: user_name)
      self.update(user_id: user.id)
    end
    sleeper
  end

  def how_to_play
    puts "Hey #{self.user.name.capitalize}! Ready to lose? Here's how to play: "
    sleeper
    puts "You'll be given a question and four possible answers."
    sleeper
    puts "Only one answer is correct!"
    sleeper
    puts "Type 1, 2, 3, or 4 with your answer"
    sleeper
    # question text
    # 1.answer 1 2. answer
  end

  def show_categories
    puts "Please select a category"
    sleeper
    counter = 0
    Category.all.each do |category|
      counter +=1
      puts "#{counter}. #{category.name} "
      sleeper
    end
  end

  def get_category
    answer = gets.chomp
    valid_answer(answer)
    answer
  end

  def valid_answer(answer)
    case answer
    when "1"
      puts "Here's a question from General"
    when "2"
      puts "Here's a question from "
    when "3"
    when "4"
    when "5"
    else
      puts "Invalid entry. Please enter your choice again"
      get_category
    end
  end

  def randomize_questions
    category = get_category
    num = rand(1..10)
    counter = 0
    question = Question.where(category: category)[num]
    puts question.question
    sleeper
    display_answers(question).each do |answer|
      counter +=1
      puts "#{counter}. #{answer}"
    end
    sleeper
  end

  def display_answers(question)
    answers_array = [question.correct_answer, question.incorrect_answer1, question.incorrect_answer2, question.incorrect_answer3]
    answers_array.shuffle
  end


end
