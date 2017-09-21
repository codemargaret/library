require('rspec')
require('pg')
require('author')
require('book')
require('patron')
require('spec_helper')
require('pry')

describe(Author) do
  describe('#name') do
    it("tells you the name") do
      author = Author.new({:name => "Richard Adams"})
      expect(author.name()).to(eq("Richard Adams"))
    end
  end

  describe('#==') do
    it('identifies identical instances as equal') do
      author1 = Author.new({:name => "Richard Adams"})
      author2 = Author.new({:name => "Richard Adams"})
      expect(author1).to(eq(author2))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Author.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves an author') do
      new_author = Author.new({:name => "Richard Adams"})
      new_author.save()
      expect(Author.all()).to(eq([new_author]))
    end
  end

  describe('#find_by_id') do
    it('finds an author based on its id') do
      new_author = Author.new({:name => "Richard Adams"})
      new_author.save
      new_author2 = Author.new({:name => "Salman Rushdie"})
      new_author2.save
      expect(Author.find_by_id(new_author2.id)).to(eq(new_author2))
    end
  end

  describe('#update_author') do
    it('updates the author field without changing the name or id') do
      new_author = Author.new({:name => "Salman Rushdie"})
      new_author.save
      new_author.update_author({:name => "Richard Adams"})
      expect(new_author.name()).to(eq("Richard Adams"))
    end

    it('lets you add a book to an author') do
      author = Author.new({:name => "Neil Gaiman"})
      author.save()
      omens = Book.new({:title => "Good Omens"})
      omens.save()
      cora = Book.new({:title => "Coraline"})
      cora.save()
      author.update_author({:id_books => [omens.id(), cora.id()]})
      expect(author.books()).to(eq([omens, cora]))
    end
  end

  describe('#books') do
    it("returns all the books by a particular author") do
      author = Author.new({:name => "Neil Gaiman"})
      author.save()
      omens = Book.new({:title => "Good Omens"})
      omens.save()
      cora = Book.new({:title => "Coraline"})
      cora.save()
      author.update_author({:id_books => [omens.id(), cora.id()]})
      expect(author.books()).to(eq([omens, cora]))
    end
  end

  describe('#delete_author') do
    it('deletes an entire row from the author table') do
      new_author = Author.new({:name => "Richard Adams"})
      new_author.save
      new_author2 = Author.new({:name => "Salman Rushdie"})
      new_author2.save
      new_author.delete_author()
      expect(Author.all()).to(eq([new_author2]))
    end
  end
end #Author class
