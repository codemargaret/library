class Author
  attr_accessor :name
  attr_reader :id

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
  end

  def self.all
    all_authors = DB.exec('SELECT * FROM authors;')
    authors = []
      all_authors.each() do |author|
        name = author.fetch("name")
        id = author.fetch("id").to_i
        authors.push(Author.new({:id => id, :name => name}))
      end
    authors
  end

  def ==(another_author)
    self.name().==(another_author.name()).&(self.id().==(another_author.id()))
  end

  def self.find_by_id(id)
    found_authors = DB.exec("SELECT * FROM authors WHERE id = '#{id}';")
    name = found_authors.first().fetch("name")
    Author.new({:id => id, :name => name})
  end #find_by_id

  def save
    saved_author = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = saved_author.first().fetch("id").to_i()
  end

  def update_author(attributes)
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE authors SET name = '#{@name}' where id = '#{self.id()}';")

    attributes.fetch(:id_books, []).each() do |id_book|
      DB.exec("INSERT INTO books_authors (id_books, id_authors) VALUES (#{id_book}, #{self.id()});")
    end
  end

  def delete_author
   DB.exec("DELETE FROM authors WHERE id = #{self.id()};")
   DB.exec("DELETE FROM books_authors WHERE id = #{self.id()};")
  end

  def books
    author_books = []
    results = DB.exec("SELECT id_books FROM books_authors WHERE id_authors = #{self.id()};")

    results.each() do |result|
      id_books = result.fetch("id_books").to_i
      book = DB.exec("SELECT * FROM books WHERE id = #{id_books};")
      title = book.first().fetch("title")
      author_books.push(Book.new({:title => title, :id => id_books}))
    end
    author_books
  end
end
