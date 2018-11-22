require 'pg'

class Bookmarks
  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  def self.list
    connection = connect()

    result = connection.exec("SELECT * FROM bookmarks;")

    result.map { |bookmark| Bookmarks.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url']) }
  end

  def self.create(url:, title:)
    connection = connect()

    result = connection.exec("INSERT INTO bookmarks (title, url) VALUES('#{title}', '#{url}') RETURNING id, url, title")

    Bookmarks.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.delete(id:)
    connection = connect()

    connection.exec("DELETE FROM bookmarks WHERE id = '#{id}'")
  end

  def self.update(id:, title:, url:)
    connection = connect()

    result = connection.exec("UPDATE bookmarks SET title = '#{title}', url = '#{url}' WHERE id = #{id} RETURNING id, url, title")

    Bookmarks.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.find(id:)
    connection = connect()

    result = connection.exec("SELECT * FROM bookmarks WHERE id = '#{id}'")

    Bookmarks.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.connect
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
  end
end
