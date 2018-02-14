class Game < ActiveRecord::Base
  has_many :game_categories
  has_many :categories, through: :game_categories
  belongs_to :user

  def start_game
    pid = fork{ exec 'afplay', "media/01 Take On Me.mp3"}
    welcome
    find_or_create_username
    how_to_play
    start_or_score
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
        puts " #{user.name.capitalize}: #{user.score}".blue
        puts " "
      end
      sleep(6)
      system "clear"
      puts " "
      puts "Now for what you've all been waiting for. Here are the categories:".blue
      puts " "
      continue_game
    else
      continue_game
    end
  end

  def continue_game
    show_categories
    randomize_questions
  end

  def sleeper
    sleep(1)
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

  sleeper



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
  sleeper

	puts "
	███╗   ███╗██╗██╗     ██╗     ██╗ ██████╗ ███╗   ██╗ █████╗ ██╗██████╗ ███████╗
	████╗ ████║██║██║     ██║     ██║██╔═══██╗████╗  ██║██╔══██╗██║██╔══██╗██╔════╝
	██╔████╔██║██║██║     ██║     ██║██║   ██║██╔██╗ ██║███████║██║██████╔╝█████╗
	██║╚██╔╝██║██║██║     ██║     ██║██║   ██║██║╚██╗██║██╔══██║██║██╔══██╗██╔══╝
	██║ ╚═╝ ██║██║███████╗███████╗██║╚██████╔╝██║ ╚████║██║  ██║██║██║  ██║███████╗
	╚═╝     ╚═╝╚═╝╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚══════╝

	 ".green
    sleeper
    say_welcome
    host
	  text_flasher("Please enter your name to get started")
		say_enter_name
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
    system("clear")
    puts " "
    puts "Hey #{self.user.name.capitalize}! Ready to lose? Here's how to play: ".blue
    sleeper
    puts " "
    puts "You'll be given a question and four possible answers.".blue
    sleeper
    puts " "
    puts "Only one answer is correct! Be sure to type the right key!".blue
    sleeper
    puts " "
    sleeper
  end


  def show_categories
    # pid = fork{ exec 'killall', "afplay" }
    # pid2 = fork{ exec 'afplay', "media/Jeopardy-theme-song.mp3"}
    counter = 0
    sleeper
    Category.all.each do |category|
      counter +=1
      puts "#{counter}. #{category.name} ".green
      puts " "
    end
    puts "Please select a category. Press 1, 2, 3, 4, or 5".blue
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
    sleeper
    puts " "
  end

  def randomize_questions
    category = get_category
    num = rand(1..30)
    counter = 0

    question = Question.where(category: category)[num]
    puts question.question.blue
    puts ' '
    puts " "
    sleeper
    answers_array = display_answers(question).map do |answer|
      counter +=1
      puts "#{counter}. #{answer}".green
      puts " "
      answer
    end
    puts "Type 1, 2, 3, or 4 with your answer".blue

    sleeper
    get_user_answer(answers_array, question)
  end

  def display_answers(question)
    answers_array = [question.correct_answer, question.incorrect_answer1, question.incorrect_answer2, question.incorrect_answer3]
    answers_array.shuffle
  end

  def get_user_answer(answers_array, question)
    # if Timeout::timeout(5){
    answer = STDIN.getch
    valid_user_answer(answer, answers_array, question)
    answer
  # }
      # valid_user_answer((1..4).to_a.sample, answers_array, question)
    # end
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

    correct_answer = question.correct_answer
    users_answer = answers_array[answer.to_i-1]
    if users_answer == correct_answer
      puts "Wow, you must be so smart. #{positive_comments.sample}".red
      puts ' '
      check_difficulty(question)
      puts "Your total score is #{user.score}".red
      puts ' '
      proceed?
    else
      system("clear")
      pid2 = fork{ exec 'afplay', "media/fail.mp3"}
      puts "#{negative_comments.sample} Sorry dumbass.... but you're.....".red
      sleeper
      puts "...."
      sleeper
      puts "........"
      sleeper

      text_flasher("


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




			")

      puts "The correct answer was #{question.correct_answer}".red
      puts ' '
      puts "Your total score is #{user.score}".red
      puts ' '
      proceed?
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

  def proceed?
    puts "Do you want to play another round?".green
    puts ' '
    puts "Select y/n".green
    answer = STDIN.getch
    system "clear"
    if answer == "y"
      puts "Great! I'm so glad you're having fun.".red
      puts ' '
      #[]comment
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
      puts "You got a final score of #{user.score}.".red
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
    neutral = ["You would pick that...", "Seriously?", "AAAAND HERE'S THE DAILY DOUBLE!!! Joking", "So yeah you must not have many friends, hu?" "I don't know anything about this topic.", "I met someone at the supermarket. Almost as smart as you.", "Why am I still hosting this show?", "This job sucks... Do you know if Google's hiring?", "Zombies eat brains. No worries, you’re safe.", "Did you hear about the pizza rat?"]
  end

  def negative_comments
    negative = ["What have you been drinking?", "Did your grandma teach you that?", "I sure hope not!", "Obviously.", "Did you even read the documentation?", "I'll start another pot of coffee.", "It’s okay if you don’t like me. Not everyone has good taste.", "If had a dollar for every smart thing you say. I’ll be poor.", "Well at least your mom thinks you’re smart.", "Are you always so stupid or is today a special ocassion?", "Everyone has the right to be stupid, but you are abusing the privilege."]
  end

  def text_flasher(text)
      puts "\e[5m#{text}\e[0m"
  end

end
