class Game

def get_questions
  questions_raw = RestClient.get("https://opentdb.com/api.php?amount=1&category=#{category}")
  JSON.parse(questions_raw)['results']
end


end
