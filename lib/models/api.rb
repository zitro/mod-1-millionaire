class Api


def category
	user_cat = gets.chomp
	if user_cat == 1
		9
	elsif user_cat == 2
		22
	user_cat
	#user category selection
		#General Knowledge = 9
		#Geography = 22
		#Celebs = 26
		#History = 23
		#Sports = 21

end

def get_questions
  questions_raw = RestClient.get("https://opentdb.com/api.php?amount=1&category=#{category}")
  JSON.parse(questions_raw)['results']
end


end
