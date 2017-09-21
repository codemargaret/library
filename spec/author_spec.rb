require('rspec')
require('pg')
require('book')
require('author')
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

end #Author class
