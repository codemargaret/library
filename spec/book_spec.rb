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
      book = Book.new({:id => nil, :title => "Watership Down", :author_id => nil})
      expect(book.id()).to(eq(nil))
    end
  end

  describe('#==') do
    it('identifies identical instances as equal') do
      book1 = Book.new({:id => nil, :title => "Watership Down", :author_id => nil})
      book2 = Book.new({:id => nil, :title => "Watership Down", :author_id => nil})
      expect(book1).to(eq(book2))
    end
  end

  describe('#title') do
    it("tells you the title") do
      book = Book.new({:id => nil, :title => "Watership Down", :author_id => nil})
      expect(book.title()).to(eq("Watership Down"))
    end
  end

  describe('#author') do
    it("tells you the author_id") do
      book = Book.new({:id => nil, :title => "Watership Down", :author_id => 45})
      expect(book.author_id()).to(eq(45))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Book.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('save a book') do
      new_book = Book.new({:id => nil, :title => "Watership Down", :author_id => 45})
      new_book.save()
      binding.pry
      expect(Book.all()).to(eq([new_book]))
    end
  end
end #Book class
