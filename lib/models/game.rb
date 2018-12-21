class Game < ActiveRecord::Base
  has_many :game_categories
  has_many :categories, through: :game_categories
  belongs_to :user

  def start_game
    pid = fork{ exec 'afplay', "media/01 Take On Me.mp3"}
    welcome
    find_or_create_username
    how_to_play
    count_rounds
    start_or_score
  end

  def continue_game
    show_categories
    randomize_questions
  end

  def say_welcome
    system "say welcome to mod one millionaire"
  end

  def host
    system "say I am your host alex truh beck"
  end

	def say_enter_name
    system "say please enter your name"
  end

  def start_or_score
    puts "Type 1 to see the scoreboard or any other key to start the game!".red
    puts " "
    answer = STDIN.getch
    if answer == "1"
      puts " "
      puts "Our top players are:".red

      User.order(:score).reverse.first(5).each do |user|
        puts " "
        puts " #{user.name.capitalize}: #{user.score}".yellow
        puts " "
      end
      sleep(6)
      system "clear"
      puts " "
      puts "Now for what you've all been waiting for. Here are the categories:".yellow
      puts " "
      continue_game
    else
      continue_game
    end
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
  sleep(1)
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
  sleep(1)

	puts "
	███╗   ███╗██╗██╗     ██╗     ██╗ ██████╗ ███╗   ██╗ █████╗ ██╗██████╗ ███████╗
	████╗ ████║██║██║     ██║     ██║██╔═══██╗████╗  ██║██╔══██╗██║██╔══██╗██╔════╝
	██╔████╔██║██║██║     ██║     ██║██║   ██║██╔██╗ ██║███████║██║██████╔╝█████╗
	██║╚██╔╝██║██║██║     ██║     ██║██║   ██║██║╚██╗██║██╔══██║██║██╔══██╗██╔══╝
	██║ ╚═╝ ██║██║███████╗███████╗██║╚██████╔╝██║ ╚████║██║  ██║██║██║  ██║███████╗
	╚═╝     ╚═╝╚═╝╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚══════╝

	 ".green
    sleep(1)
    say_welcome
    host
	  puts "Please enter your name to get started".bold.blink
		say_enter_name
	  sleep(1)
	  end

  def find_or_create_username
    user_name = gets.chomp.downcase
    sleep(1)
    if user_name == nil || user_name == ""
      puts "Invalid entry, please enter your name"
      find_or_create_username
    else
      user = User.find_or_create_by(name: user_name)
      self.update(user_id: user.id)
    end
    sleep(1)
  end

  def how_to_play
    system("clear")
    puts " "
    puts "Hey #{self.user.name.capitalize}! Ready to lose? Here's how to play: ".yellow
    sleep(1)
    puts " "
    puts "You'll be given a question and four possible answers.".yellow
    sleep(1)
    puts " "
    puts "Only one answer is correct! Be sure to type the right key!".yellow
    sleep(1)
    puts " "
    sleep(1)
  end

  def count_rounds
    self.update(round_counter: (self.round_counter + 1))
  end

  def show_categories
    puts "Welcome to Round #{self.round_counter}!".bold.underline
    puts " "
    sleep(1)
    counter = 0
    sleep(1)
    Category.first(5).each do |category|
      counter +=1
      puts "#{counter}. #{category.name} ".green
      puts " "
    end
    puts "Please select a category. Press 1, 2, 3, 4, or 5".yellow
    puts " "
  end

  def get_category
    answer = STDIN.getch
    valid_answer(answer)
    answer
  end

  def valid_answer(answer)
    puts " "
    case answer
    when "1"
      puts "General Knowledge: #{neutral_comments.sample}".red
    when "2"
      puts "Geography: #{neutral_comments.sample}".red
    when "3"
      puts "Celebrities: #{neutral_comments.sample}".red
    when "4"
      puts "History: #{neutral_comments.sample}".red
    when "5"
      puts "Sports: #{neutral_comments.sample}".red
    else
      puts "Invalid entry. Please enter your choice again".red
      get_category
    end
    sleep(1)
    puts " "
  end

  def randomize_questions
    category = get_category
    num = rand(1..30)
    counter = 0
    user.update(bet: 0)
    question = Question.where(category: category)[num]
    puts question.question.yellow
    puts ' '
    puts " "
    sleep(1)
    answers_array = display_answers(question).map do |answer|
      counter +=1
      puts "#{counter}. #{answer}".green
      puts " "
      answer
    end
    puts "Type 1, 2, 3, or 4 with your answer".yellow
    sleep(1)
    get_user_answer(answers_array, question)
  end

  def display_answers(question)
    answers_array = [question.correct_answer, question.incorrect_answer1, question.incorrect_answer2, question.incorrect_answer3]
    answers_array.shuffle
  end

  def get_user_answer(answers_array, question)
    answer = STDIN.getch
    valid_user_answer(answer, answers_array, question)
    answer
  end

  def valid_user_answer(answer, answers_array, question)
    if answer == "1" || answer == "2" || answer == "3" || answer == "4"
      correct?(answer, answers_array, question)
    else
      puts "Invalid entry. Please enter your choice again"
      get_user_answer(answers_array, question)
    end
  end

  def correct?(answer, answers_array, question)
    count_rounds
    correct_answer = question.correct_answer
    users_answer = answers_array[answer.to_i-1]
    if users_answer == correct_answer
      user.update(score: (user.score + user.bet))
      puts "Wow, you must be so smart. #{positive_comments.sample}".red
			puts "You we're right! The correct answer was #{question.correct_answer}.".red
      puts ' '
      check_difficulty(question)
      puts "Your total score is #{user.score}".red
      puts ' '
      sleep(3)
      check_for_dj
    else
      system("clear")
      pid2 = fork{ exec 'afplay', "media/fail.mp3"}
      user.update(score: (user.score - user.bet))
      puts " "
      puts "You picked #{users_answer}???!!!!"
			puts " "
      puts "#{negative_comments.sample} Sorry dumbass.... but you're.....".red
      sleep(1)
      puts "...."
      sleep(1)
      puts "........"
      sleep(2)
      puts "


			 ▄         ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄        ▄  ▄▄▄▄▄▄▄▄▄▄▄
			▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░▌      ▐░▌▐░░░░░░░░░░░▌
			▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░▌░▌     ▐░▌▐░█▀▀▀▀▀▀▀▀▀
			▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░▌▐░▌    ▐░▌▐░▌
			▐░▌   ▄   ▐░▌▐░█▄▄▄▄▄▄▄█░▌▐░▌       ▐░▌▐░▌ ▐░▌   ▐░▌▐░▌ ▄▄▄▄▄▄▄▄
			▐░▌  ▐░▌  ▐░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░▌  ▐░▌  ▐░▌▐░▌▐░░░░░░░░▌
			▐░▌ ▐░▌░▌ ▐░▌▐░█▀▀▀▀█░█▀▀ ▐░▌       ▐░▌▐░▌   ▐░▌ ▐░▌▐░▌ ▀▀▀▀▀▀█░▌
			▐░▌▐░▌ ▐░▌▐░▌▐░▌     ▐░▌  ▐░▌       ▐░▌▐░▌    ▐░▌▐░▌▐░▌       ▐░▌
			▐░▌░▌   ▐░▐░▌▐░▌      ▐░▌ ▐░█▄▄▄▄▄▄▄█░▌▐░▌     ▐░▐░▌▐░█▄▄▄▄▄▄▄█░▌
			▐░░▌     ▐░░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░▌      ▐░░▌▐░░░░░░░░░░░▌
			 ▀▀       ▀▀  ▀         ▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀        ▀▀  ▀▀▀▀▀▀▀▀▀▀▀




			".blink
			sleep(2)
      puts "The correct answer was #{question.correct_answer}".red
      puts ' '
      puts "Your total score is #{user.score}".red
      puts ' '
			sleep(5)
      check_for_dj
    end
  end

  def check_difficulty(question)
    if question.difficulty == "easy"
      user.update(score: (user.score + 100))
    elsif question.difficulty == "medium"
      user.update(score: (user.score + 200))
    elsif question.difficulty == "hard"
      user.update(score: (user.score + 300))
    end
  end

  def check_for_dj
    if user.score == 0
      proceed?
    elsif self.round_counter % 3 == 0
      launch_double_jeopardy
    else
      proceed?
    end
  end

  def launch_double_jeopardy
    system "clear"
		puts "


		 ▄▄▄▄▄▄▄▄▄▄   ▄▄▄▄▄▄▄▄▄▄▄  ▄         ▄  ▄▄▄▄▄▄▄▄▄▄   ▄            ▄▄▄▄▄▄▄▄▄▄▄
		▐░░░░░░░░░░▌ ▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░▌ ▐░▌          ▐░░░░░░░░░░░▌
		▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀█░▌▐░▌          ▐░█▀▀▀▀▀▀▀▀▀
		▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░▌          ▐░▌
		▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄█░▌▐░▌          ▐░█▄▄▄▄▄▄▄▄▄
		▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░░░░░░░░░░▌ ▐░▌          ▐░░░░░░░░░░░▌
		▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀█░▌▐░▌          ▐░█▀▀▀▀▀▀▀▀▀
		▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░▌          ▐░▌
		▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄▄▄
		▐░░░░░░░░░░▌ ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░▌ ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
		 ▀▀▀▀▀▀▀▀▀▀   ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀   ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀

		 ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄   ▄         ▄
		▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░▌ ▐░▌       ▐░▌
		 ▀▀▀▀▀█░█▀▀▀ ▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░▌       ▐░▌
		      ▐░▌    ▐░▌          ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌
		      ▐░▌    ▐░█▄▄▄▄▄▄▄▄▄ ▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄█░▌
		      ▐░▌    ▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌
		      ▐░▌    ▐░█▀▀▀▀▀▀▀▀▀ ▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀█░█▀▀ ▐░▌       ▐░▌ ▀▀▀▀█░█▀▀▀▀
		      ▐░▌    ▐░▌          ▐░▌       ▐░▌▐░▌          ▐░▌       ▐░▌▐░▌     ▐░▌  ▐░▌       ▐░▌     ▐░▌
		 ▄▄▄▄▄█░▌    ▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌▐░▌          ▐░▌       ▐░▌▐░▌      ▐░▌ ▐░█▄▄▄▄▄▄▄█░▌     ▐░▌
		▐░░░░░░░▌    ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌          ▐░▌       ▐░▌▐░▌       ▐░▌▐░░░░░░░░░░▌      ▐░▌
		 ▀▀▀▀▀▀▀      ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀            ▀         ▀  ▀         ▀  ▀▀▀▀▀▀▀▀▀▀        ▀




		"

    puts "You've made it to Double Jeopardy!".yellow
    puts " "
    puts "You currently have #{user.score} points!".yellow
    puts " "
    puts "Few make it this far... I never thought you'd be one!".yellow
    puts " "
    sleep(1)
    puts "You can bet it all -- or nothing if you're lame.".yellow
    puts " "
    puts "How many points would you like to wager?".yellow
    puts " "
    get_dj_answer
  end

  def get_dj_answer
    answer = gets.chomp
    validate_dj_answer(answer)
  end

  def validate_dj_answer(answer)
    if answer.to_i > 0 && answer.to_i <= user.score
      user.update(bet: answer.to_i)
      puts "Thanks for betting #{answer}. You should've bet ZERO!".red
      puts " "
			system "clear"
      double_jeopardy_question_randomizer
    else
      puts "Sorry you can't bet #{answer}!".red
      puts " "
      puts "Let's try again."
      get_dj_answer
    end
  end

  def double_jeopardy_question_randomizer
      num = rand(1..30)
      counter = 0

      question = Question.where(category: 6)[num]
      puts question.question.yellow
      puts ' '
      puts " "
      sleep(1)
      answers_array = display_answers(question).map do |answer|
        counter +=1
        puts "#{counter}. #{answer}".green
        puts " "
        answer
      end
      puts "Type 1, 2, 3, or 4 with your answer".yellow
      sleep(1)
      get_user_answer(answers_array, question)
  end

  def proceed?
		system "clear"
		puts ' '
		puts '


		 ██████╗ ██████╗ ███╗   ██╗████████╗██╗███╗   ██╗██╗   ██╗███████╗██████╗
		██╔════╝██╔═══██╗████╗  ██║╚══██╔══╝██║████╗  ██║██║   ██║██╔════╝╚════██╗
		██║     ██║   ██║██╔██╗ ██║   ██║   ██║██╔██╗ ██║██║   ██║█████╗    ▄███╔╝
		██║     ██║   ██║██║╚██╗██║   ██║   ██║██║╚██╗██║██║   ██║██╔══╝    ▀▀══╝
		╚██████╗╚██████╔╝██║ ╚████║   ██║   ██║██║ ╚████║╚██████╔╝███████╗  ██╗
		 ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝  ╚═╝





		'
		puts "Do you want to play another round?".green.blink
		puts ' '
    puts "Select y/n".green
    answer = STDIN.getch
    system "clear"
    if answer == "y"
			puts ' '
			puts "Great! I'm so glad you're having fun.".red
      puts ' '
      puts "In this session, you've played #{self.round_counter} rounds and have a total score of #{user.score}. I'm so proud of you.".red
      puts " "
      continue_game
    elsif answer == "n"
      pid = fork{ exec 'killall', "afplay" }
      system("clear")
      puts " "
      puts " "
      puts "Quitting is losing. #{user.name.upcase}\'S A LOSER!!!!".red
      puts "
    ██╗   ██╗ ██████╗ ██╗   ██╗██████╗ ███████╗
    ╚██╗ ██╔╝██╔═══██╗██║   ██║██╔══██╗██╔════╝
     ╚████╔╝ ██║   ██║██║   ██║██████╔╝█████╗
      ╚██╔╝  ██║   ██║██║   ██║██╔══██╗██╔══╝
       ██║   ╚██████╔╝╚██████╔╝██║  ██║███████╗
       ╚═╝    ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝

                       █████╗
                       ██╔══██╗
                       ███████║
                       ██╔══██║
                       ██║  ██║
                       ╚═╝  ╚═╝

      ██╗      ██████╗ ███████╗███████╗██████╗
      ██║     ██╔═══██╗██╔════╝██╔════╝██╔══██╗
      ██║     ██║   ██║███████╗█████╗  ██████╔╝
      ██║     ██║   ██║╚════██║██╔══╝  ██╔══██╗
      ███████╗╚██████╔╝███████║███████╗██║  ██║
      ╚══════╝ ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝".red

      puts " "
      puts "You played #{self.round_counter} round(s). You got a final score of #{user.score}.".red
      puts ' '
      puts "You'll never be smarter than me.".red
      exit
      return " "
    else
      "Not a valid response... try again"
      proceed?
    end
  end

  def positive_comments
    positive = ["NERD!!!!", "I'm so impressed... yawn", "How the hell did you know that???", "Harvard grad, huh?", "THAT was impressive.", "Obviously.", "You can JOIN my TABLE anyday.", "You're really ARRAY of light.", "Another successful merge!", "Life’s good, you should get one.", "Unless your name is Google stop acting like you know everything."]
  end

  def neutral_comments
    neutral = ["You would pick that...", "Seriously?", "AAAAND HERE'S THE DAILY DOUBLE!!! Joking", "So yeah you must not have many friends, huh? " "I don't know anything about this topic.", "I met someone at the supermarket. Almost as smart as you.", "Why am I still hosting this show?", "This job sucks... Do you know if Google's hiring?", "Zombies eat brains. No worries, you’re safe.", "Did you hear about the pizza rat?"]
  end

  def negative_comments
    negative = ["What have you been drinking?", "Did your grandma teach you that?", "I sure hope not!", "Obviously.", "Did you even read the documentation?", "I'll start another pot of coffee.", "It’s okay if you don’t like me. Not everyone has good taste.", "If had a dollar for every smart thing you say. I’d be poor. ", "Well at least your mom thinks you’re smart.", "Are you always so stupid or is today a special ocassion?", "Everyone has the right to be stupid, but you are abusing the privilege."]
  end
end
