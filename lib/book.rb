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
        books.push(Book.new({:id => id, :title => title, :author_id => author_id}))
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
    found_books = DB.exec("SELECT * FROM books WHERE id = '#{id}';")
    title = found_books.first().fetch("title")
    author_id = found_books.first().fetch("author_id")
    Book.new({:id => id, :title => title, :author_id => author_id})
  end #find_by_id

  def update_title(attributes)
    @title = attributes.fetch(:title, @title)
    @id = self.id()
    DB.exec("UPDATE books SET title = '#{@title}' where id = '#{@id}';")
  end

  def update_author_id(attributes)
    @author_id = attributes.fetch(:author_id, @author_id)
    @id = self.id()
    DB.exec("UPDATE books SET author_id = '#{@author_id}' where id = '#{@id}';")
  end

end #Book class
