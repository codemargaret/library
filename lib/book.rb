class Book
  attr_accessor :title, :author_id
  attr_reader :id

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @title = attributes.fetch(:title)
    @author_id = attributes.fetch(:author_id).to_i()
  end


  def self.all
    all_books = DB.exec('SELECT * FROM books;')
    books = []
      all_books.each() do |book|
        title = book.fetch("title")
        id = book.fetch("id").to_i
        author_id = book.fetch("author_id")
        books.push(Book.new({:title => title, :id => id, :author_id => author_id}))
      end
    books
  end

  def save
    saved_book = DB.exec("INSERT INTO books (title, author_id) VALUES ('#{@title}', '#{@author_id}') RETURNING id;")
    @id = saved_book.first().fetch("id").to_i()
  end

  def ==(another_book)
    self.title().==(another_book.title()).&(self.author_id().==(another_book.author_id())).&(self.id().==(another_book.id()))
  end

  def self.find_by_id(id)
    found_books = DB.exec('SELECT * FROM books;')
    books = []
    found_books.each() do |book|
      found_id = book.fetch("id").to_i
      if found_id == id
        books.push(book)
      end #if
    end #do
    books.first().fetch("title")
  end #find_by_id

end #Book class
