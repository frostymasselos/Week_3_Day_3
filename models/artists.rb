require('pg')
require_relative('albums')
require_relative('../db/sql_runner')

class Artists

  attr_reader :artist_name, :id

  def initialize(options)
    @artist_name = options['artist_name']
    @id = options['id'].to_i if options['id']
  end

  def save
    db = PG.connect( {
      dbname: 'music_lab',
      host: 'localhost'
      })
    sql = "INSERT INTO artists (
    artist_name
    )
    VALUES
    (
      $1
    )
    RETURNING id;"
    values = [@artist_name]
    db.prepare("save", sql)
    result = db.exec_prepared("save", values)
    db.close()
    @id = result[0]['id'].to_i

  end

  def albums
    sql = "SELECT * FROM albums
    WHERE artist_id = $1"
    values = [@id]
    album_hashes = SqlRunner.run(sql, values)
    album_objects = album_hashes.map { |album_hash| Albums.new(album_hash) }
    return album_objects
  end
  # It asks for many because there could be many albums that reference this
  #artist. (Think one to many).

  def update()
  sql = "UPDATE artists
  SET
  (
    artist_name
  ) =
  (
    $1
  )
  WHERE id = $2"
  values = [@artist_name, @id]
  SqlRunner.run(sql, values)
end

  def self.all
    sql = "SELECT * FROM artists"
    artists_hashes = SqlRunner.run(sql)
    artists_objects = artists_hashes.map{|artist| Artists.new(artist)}
    return artists_objects
  end

end
