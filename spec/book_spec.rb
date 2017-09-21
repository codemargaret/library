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
      book = Book.new({:id => nil, :title => "Watership Down"})
      expect(book.id()).to(eq(nil))
    end
  end

  describe('#==') do
    it('identifies identical instances as equal') do
      book1 = Book.new({:id => nil, :title => "Watership Down"})
      book2 = Book.new({:id => nil, :title => "Watership Down"})
      expect(book1).to(eq(book2))
    end
  end

  describe('#title') do
    it("tells you the title") do
      book = Book.new({:id => nil, :title => "Watership Down"})
      expect(book.title()).to(eq("Watership Down"))
    end
  end

  # describe('#find_author') do
  #   it("tells you the author of the book") do
  #     book = Book.new({:id => nil, :title => "Watership Down"})
  #     author = Author.new()
  #     expect(book.find_author()).to(eq("Richard Adams"))
  #   end
  # end

  describe('.all') do
    it('is empty at first') do
      expect(Book.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('save a book') do
      new_book = Book.new({:id => nil, :title => "Watership Down"})
      new_book.save()
      expect(Book.all()).to(eq([new_book]))
    end
  end

  describe('#find_by_id') do
    it('finds a book based on its id') do
      new_book = Book.new({:id => nil, :title => "Watership Down"})
      new_book.save
      new_book2 = Book.new({:id => nil, :title => "The Ground Beneath Her Feet"})
      new_book2.save
      expect(Book.find_by_id(new_book2.id)).to(eq(new_book2))
    end
  end

  describe('#update_title') do
    it('updates the title field without changing the author or id') do
      new_book = Book.new({:id => nil, :title => "The Satanic Verses"})
      new_book.save
      new_book.update_title({:title => "The Ground Beneath Her Feet"})
      expect(new_book.title()).to(eq("The Ground Beneath Her Feet"))
    end
  end

  describe('#delete_book') do
    it('deletes an entire row from the book table') do
      new_book = Book.new({:id => nil, :title => "Watership Down"})
      new_book.save
      new_book2 = Book.new({:id => nil, :title => "The Satanic Verses"})
      new_book2.save
      new_book.delete_book()
      expect(Book.all()).to(eq([new_book2]))
    end
  end

end #Book class
