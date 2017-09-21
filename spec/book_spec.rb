require('rspec')
require('pry')
require('pg')
require('book')
require('author')
require('patron')
require('spec_helper')

describe(Book) do
  describe('#id') do
    it("tells you the id") do
      book = Book.new({:title => "Watership Down"})
      expect(book.id()).to(eq(nil))
    end
  end

  describe('#==') do
    it('identifies identical instances as equal') do
      book1 = Book.new({:title => "Watership Down"})
      book2 = Book.new({:title => "Watership Down"})
      expect(book1).to(eq(book2))
    end
  end

  describe('#title') do
    it("tells you the title") do
      book = Book.new({:title => "Watership Down"})
      expect(book.title()).to(eq("Watership Down"))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Book.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('save a book') do
      new_book = Book.new({:title => "Watership Down"})
      new_book.save()
      expect(Book.all()).to(eq([new_book]))
    end
  end

  describe('#find_by_id') do
    it('finds a book based on its id') do
      new_book = Book.new({:title => "Watership Down"})
      new_book.save
      new_book2 = Book.new({:title => "The Ground Beneath Her Feet"})
      new_book2.save
      expect(Book.find_by_id(new_book2.id)).to(eq(new_book2))
    end
  end

  describe('#update_book') do
    it('updates the title field without changing the author or id') do
      new_book = Book.new({:title => "The Satanic Verses"})
      new_book.save
      new_book.update_book({:title => "The Ground Beneath Her Feet"})
      expect(new_book.title()).to(eq("The Ground Beneath Her Feet"))
    end
    it('lets you add an author to a book') do
      book = Book.new({:title => "Good Omens"})
      book.save()
      neil = Author.new({:name => "Neil Gaiman"})
      neil.save()
      terry = Author.new({:name => "Terry Pratchett"})
      terry.save()
      book.update_book({:id_authors => [neil.id(), terry.id()]})
      expect(book.authors()).to(eq([neil, terry]))
    end
  end

  describe('#authors') do
    it("returns all the authors of a particular book") do
      book = Book.new({:title => "Good Omens"})
      book.save()
      neil = Author.new({:name => "Neil Gaiman"})
      neil.save()
      terry = Author.new({:name => "Terry Pratchett"})
      terry.save()
      book.update_book({:id_authors => [neil.id(), terry.id()]})
      expect(book.authors()).to(eq([neil, terry]))
    end
  end

  describe('#delete_book') do
    it('deletes an entire row from the book table') do
      new_book = Book.new({:title => "Watership Down"})
      new_book.save
      new_book2 = Book.new({:title => "The Satanic Verses"})
      new_book2.save
      new_book.delete_book()
      expect(Book.all()).to(eq([new_book2]))
    end
  end

  # describe('#find_author') do
  #   it("tells you the author of the book") do
  #     book_a = Book.new({:title => "Watership Down"})
  #     book_a.save
  #     author_a = Author.new({:name => "Richard Adams"})
  #     author_a.save
  #     expect(book_a.find_author()).to(eq(author_a))
  #   end
  # end
end #Book class
