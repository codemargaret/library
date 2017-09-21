class Author
  attr_accessor :name
  attr_reader :id

  def initialize(attributes)
    # @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
  end

  def self.all
    all_authors = DB.exec('SELECT * FROM authors;')
    authors = []
      all_authors.each() do |author|
        title = author.fetch("name")
        # id = author.fetch("id").to_i
        authors.push(Book.new({:name => name}))
      end
    authors
  end

  def ==(another_author)
    self.name().==(another_author.name()).&(self.id().==(another_author.id()))
  end
end
