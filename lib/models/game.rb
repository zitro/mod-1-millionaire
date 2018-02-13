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
	puts " "
	puts " "
			puts "
	██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗    ████████╗ ██████╗
	██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝    ╚══██╔══╝██╔═══██╗
	██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗         ██║   ██║   ██║
	██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝         ██║   ██║   ██║
	╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗       ██║   ╚██████╔╝
	 ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝       ╚═╝    ╚═════╝

	".red



			puts"

	                                                            dddddddd
	MMMMMMMM               MMMMMMMM                             d::::::d       1111111
	M:::::::M             M:::::::M                             d::::::d      1::::::1
	M::::::::M           M::::::::M                             d::::::d     1:::::::1
	M:::::::::M         M:::::::::M                             d:::::d      111:::::1
	M::::::::::M       M::::::::::M   ooooooooooo       ddddddddd:::::d         1::::1
	M:::::::::::M     M:::::::::::M oo:::::::::::oo   dd::::::::::::::d         1::::1
	M:::::::M::::M   M::::M:::::::Mo:::::::::::::::o d::::::::::::::::d         1::::1
	M::::::M M::::M M::::M M::::::Mo:::::ooooo:::::od:::::::ddddd:::::d         1::::l
	M::::::M  M::::M::::M  M::::::Mo::::o     o::::od::::::d    d:::::d         1::::l
	M::::::M   M:::::::M   M::::::Mo::::o     o::::od:::::d     d:::::d         1::::l
	M::::::M    M:::::M    M::::::Mo::::o     o::::od:::::d     d:::::d         1::::l
	M::::::M     MMMMM     M::::::Mo::::o     o::::od:::::d     d:::::d         1::::l
	M::::::M               M::::::Mo:::::ooooo:::::od::::::ddddd::::::dd     111::::::111
	M::::::M               M::::::Mo:::::::::::::::o d:::::::::::::::::d     1::::::::::1
	M::::::M               M::::::M oo:::::::::::oo   d:::::::::ddd::::d     1::::::::::1
	MMMMMMMM               MMMMMMMM   ooooooooooo      ddddddddd   ddddd     111111111111







	".green


	puts "
	███╗   ███╗██╗██╗     ██╗     ██╗ ██████╗ ███╗   ██╗ █████╗ ██╗██████╗ ███████╗
	████╗ ████║██║██║     ██║     ██║██╔═══██╗████╗  ██║██╔══██╗██║██╔══██╗██╔════╝
	██╔████╔██║██║██║     ██║     ██║██║   ██║██╔██╗ ██║███████║██║██████╔╝█████╗
	██║╚██╔╝██║██║██║     ██║     ██║██║   ██║██║╚██╗██║██╔══██║██║██╔══██╗██╔══╝
	██║ ╚═╝ ██║██║███████╗███████╗██║╚██████╔╝██║ ╚████║██║  ██║██║██║  ██║███████╗
	╚═╝     ╚═╝╚═╝╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚══════╝

	 ".green

	 puts "Please enter your name to get started".green
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
    answers_array = display_answers(question).map do |answer|
      counter +=1
      puts "#{counter}. #{answer}"
      answer
    end

    sleeper
    get_user_answer(answers_array, question)
  end

  def display_answers(question)
    answers_array = [question.correct_answer, question.incorrect_answer1, question.incorrect_answer2, question.incorrect_answer3]
    answers_array.shuffle
  end

  def get_user_answer(answers_array, question)
    answer = gets.chomp
    valid_user_answer(answer, answers_array, question)
    answer
  end

  def valid_user_answer(answer, answers_array, question)
     # checks if
     # users_answer = answers_array[answer.to_i-1]
     # users_answer == correct_answer
    correct_answer = question.correct_answer
    answers_array
    answer.to_i
    binding.pry
    case answer
    when "1"
      puts ""
    when "2"
      puts "Here's a question from "
    when "3"
    when "4"
    else
      puts "Invalid entry. Please enter your choice again"
      get_user_answer
    end
  end


end
