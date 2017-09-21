class Book
  attr_accessor :title
  attr_reader :id

  def initialize(attributes)
    @id = attributes[:id]
    @title = attributes[:title]
  end


  def self.all
    all_books = DB.exec('SELECT * FROM books;')
    books = []
      all_books.each() do |book|
        title = book.fetch("title")
        id = book.fetch("id").to_i
        books.push(Book.new({:id => id, :title => title}))
      end
    books
  end

  def save
    saved_book = DB.exec("INSERT INTO books (title) VALUES ('#{@title}') RETURNING id;")
    @id = saved_book.first().fetch("id").to_i()
  end

  def ==(another_book)
    self.title().==(another_book.title()).&(self.id().==(another_book.id()))
  end

  def self.find_by_id(id)
    found_books = DB.exec("SELECT * FROM books WHERE id = '#{id}';")
    title = found_books.first().fetch("title")
    Book.new({:id => id, :title => title})
  end #find_by_id

  def update_book(attributes)
    @title = attributes.fetch(:title, @title)
    DB.exec("UPDATE books SET title = '#{@title}' where id = #{self.id()};")

    attributes.fetch(:id_authors, []).each() do |id_author|
      DB.exec("INSERT INTO books_authors (id_authors, id_books) VALUES (#{id_author}, #{self.id()});")
    end
  end

  def delete_book
   DB.exec("DELETE FROM books WHERE id = #{self.id()};")
   DB.exec("DELETE FROM books_authors WHERE id = #{self.id()};")
  end

  def authors
    book_authors = []
    results = DB.exec("SELECT id_authors FROM books_authors WHERE id_books = #{self.id()};")
    results.each() do |result|
      id_authors = result.fetch("id_authors").to_i
      author = DB.exec("SELECT * FROM authors WHERE id = #{id_authors};")
      name = author.first().fetch("name")
      book_authors.push(Author.new({:name => name, :id => id_authors}))
    end
    book_authors
  end
end #Book class
