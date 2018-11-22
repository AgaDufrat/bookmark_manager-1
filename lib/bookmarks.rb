require './database_connection_setup'

class Bookmarks
  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  def self.list
    result = DatabaseConnection.query("SELECT * FROM bookmarks;")

    result.map { |bookmark| Bookmarks.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url']) }
  end

  def self.create(url:, title:)
    result = DatabaseConnection.query("INSERT INTO bookmarks (title, url) VALUES('#{title}', '#{url}') RETURNING id, url, title")

    Bookmarks.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = '#{id}'")
  end

  def self.update(id:, title:, url:)


    result = DatabaseConnection.query("UPDATE bookmarks SET title = '#{title}', url = '#{url}' WHERE id = #{id} RETURNING id, url, title")

    Bookmarks.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = '#{id}'")

    Bookmarks.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

end
