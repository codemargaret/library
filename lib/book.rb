class Book
  attr_accessor :title
  attr_reader :id

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @title = attributes.fetch(:title)
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

  def update_title(attributes)
    @title = attributes.fetch(:title, @title)
    @id = self.id()
    DB.exec("UPDATE books SET title = '#{@title}' where id = '#{@id}';")
  end

  def delete_book
   DB.exec("DELETE FROM books WHERE id = #{self.id()};")
  end

end #Book class
