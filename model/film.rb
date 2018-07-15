require_relative('../db/sql_runner')

class Film

  attr_reader :id, :price
  attr_writer :title, :price
  def initialize options
    @id = options['id'] if options['id']
    @price = options['price'].to_f
    @title = options['title']
  end

  def save
    sql = "INSERT INTO films (price, title) VALUES ($1, $2) RETURNING id;"
    values = [@price, @title]
    result = SqlRunner.run(sql, values)
    @id = result.first['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM films;"
    result = SqlRunner.run(sql)
    films = result.map {|film| Film.new(film)}
    return films
  end

  def update
    sql = "UPDATE films SET (price, title) = ($1, $2) WHERE id = $3;"
    values = [@price, @title, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM films WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def customers
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON tickets.customer_id = customers.id WHERE tickets.film_id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values)
    customers = result.map {|customer| Customer.new(customer)}
    return customers
  end

  def self.find_by_id id
    sql = "SELECT * FROM films WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values)
    film = Film.new(result.first)
    return film
  end

  def number_of_customers
    customers.length
  end

  def screenings
    sql = "SELECT screenings.* FROM screenings INNER JOIN tickets ON tickets.screening_id = screenings.id WHERE tickets.film_id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values)
    screenings = result.map {|screening| Screening.new(screening)}
    return screenings
  end

  def most_popular_show_time
    sql = "SELECT COUNT(tickets.id), screenings.show_time FROM screenings INNER JOIN tickets ON tickets.screening_id = screenings.id INNER JOIN films ON tickets.film_id = films.id WHERE tickets.film_id = $1 GROUP BY show_time ORDER BY COUNT(tickets.id) DESC LIMIT 1;"
    values = [@id]
    result = SqlRunner.run(sql, values)
    show_time = result.first['show_time']
    return show_time
  end

end
