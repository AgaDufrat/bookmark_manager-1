require 'bookmarks'
require 'database_helpers'

describe Bookmarks do
  describe '.list' do
    it 'should display a list of bookmarks' do

      bookmark = Bookmarks.create(url: "http://www.makersacademy.com", title: "Makers Academy")
      Bookmarks.create(url: "http://www.makersacademy.com", title: "Makers Academy")
      Bookmarks.create(url: "http://www.makersacademy.com", title: "Makers Academy")

      bookmarks = Bookmarks.list

      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmarks
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers Academy'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
    end
  end

  describe '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmarks.create(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
      persisted_data = persisted_data(id: bookmark.id)
      expect(bookmark).to be_a Bookmarks
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq 'Test Bookmark'
      expect(bookmark.url).to eq 'http://www.testbookmark.com'
    end
  end

  describe '.delete' do
    it 'deletes a bookmark' do
      bookmark = Bookmarks.create(url: "http://www.makersacademy.com", title: "Makers Academy")

      bookmarks = Bookmarks.list
      expect(bookmarks).not_to be_empty

      Bookmarks.delete(id: bookmark.id)
      bookmarks = Bookmarks.list

      expect(bookmarks).to be_empty
    end
  end

  describe '.update' do
    it 'deletes a bookmark' do
      bookmark = Bookmarks.create(url: "http://www.makersacademy.com", title: "Makers Academy")

      bookmark = Bookmarks.update(id: bookmark.id, title: "New Academy", url: "http:/na.com")

      persisted_data = persisted_data(id: bookmark.id)
      expect(bookmark).to be_a Bookmarks
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq 'New Academy'
      expect(bookmark.url).to eq 'http:/na.com'
    end
  end

  describe '.find' do
    it 'finds a bookmark' do
      bookmark = Bookmarks.create(url: "http://www.makersacademy.com", title: "Makers Academy")
      bookmark2 = Bookmarks.find(id: bookmark.id)
      expect(bookmark2.id).to eq bookmark.id
      expect(bookmark2.url).to eq bookmark.url
      expect(bookmark2.title).to eq bookmark.title
    end
  end

end
