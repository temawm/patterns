class Person
  attr_reader :id, :github

  def initialize(id:, github: nil)
    @id = id
    self.github = github
  end

  private

  def github=(github)
    if self.class.github_checker(github)
      @github = github
    else
      raise ArgumentError, "Некорректный GitHub URL"
    end
  end

  def self.github_checker(github)
    github.nil? || github.match?(/^https:\/\/github\.com\/[a-zA-Z0-9_-]+/)
  end
end
