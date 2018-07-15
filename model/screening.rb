require_relative('../db/sql_runner')
class Screening

  attr_reader :id, :capacity
  attr_accessor :show_time, :occupied_seats
  def initialize options
    @id = options['id'].to_i if options['id']
    @show_time = options['show_time']
    @capacity = 3
    @occupied_seats = 0
    @film_id = options['film_id']
  end

  def save
    sql = "INSERT INTO screenings (show_time, capacity, occupied_seats, film_id) VALUES ($1, $2, $3, $4) RETURNING id;"
    values = [@show_time, @capacity, @occupied_seats, @film_id]
    result = SqlRunner.run(sql, values)
    @id = result.first['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM screenings"
    result = SqlRunner.run(sql)
    screenings = result.map {|screening| Screening.new(screening)}
    return screenings
  end

  def update
    sql = "UPDATE screenings SET (show_time, capacity, occupied_seats, film_id) = ($1, $2, $3, $4) WHERE id = $5;"
    values = [@show_time, @capacity, @occupied_seats, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM screenings WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def self.find_by_id id
    sql = "SELECT * FROM screenings WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values)
    film = Screening.new(result.first)
    return film
  end

  def find_price
    sql = "SELECT price FROM films WHERE id = $1;"
    values = [@film_id]
    result = SqlRunner.run(sql, values)
    price = result.first['price']
    return price
  end

  def increase_seats_taken
    @occupied_seats = occupied_seats + 1
  end

  def occupied_seats
    sql = "SELECT occupied_seats FROM screenings WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    occupied_seats = result.first['occupied_seats'].to_i
    return occupied_seats
  end
end
