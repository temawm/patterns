class Person
  attr_reader :id, :github

  def initialize(id:, github: nil)
    @id = id
    self.github = github
  end
  
  def self.github_checker(github)
    github.nil? || github.match?(/^https:\/\/github\.com\/[a-zA-Z0-9_-]+/)
  end
  
  def contact
	raise NotImplementedError, "You must implement the 'contacts' method in a subclass"
  end	
  
  def initials
	raise NotImplementedError, "You must implement the 'initials' method in a subclass"
  end	
  
  private

  def github=(github)
    if self.class.github_checker(github)
      @github = github
    else
      raise ArgumentError, "Некорректный GitHub URL"
    end
  end

end
