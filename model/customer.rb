require_relative('../db/sql_runner')
require_relative('screening')
require_relative('film')
class Customer
  attr_reader :id
  attr_writer :name
  def initialize options
    @id = options['id'] if options['id']
    @funds = options['funds'].to_f
    @name = options['name']
  end

  def save
    sql = "INSERT INTO customers (funds, name) VALUES ($1, $2) RETURNING id;"
    values = [@funds, @name]
    result = SqlRunner.run(sql, values)
    @id = result.first['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM customers"
    result = SqlRunner.run(sql)
    customers = result.map {|customer| Customer.new(customer)}
    return customers
  end

  def update
    sql = "UPDATE customers SET (funds, name) = ($1, $2) WHERE id = $3;"
    values = [@funds, @name, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM customers WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def films
    sql = "SELECT films.* FROM films INNER JOIN tickets ON tickets.film_id = films.id WHERE tickets.customer_id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values)
    films = result.map {|film| Film.new(film)}
    return films
  end

  def buy_ticket screening
    if screening.occupied_seats < screening.capacity
      updated_funds = @funds - screening.find_price.to_f
      @funds = updated_funds.round(2)
      update
      screening.increase_seats_taken
      screening.update
      new_ticket = Ticket.new({'customer_id' => @id, 'screening_id' => screening.id})
      new_ticket.save
    end
  end

  def self.find_by_id id
    sql = "SELECT * FROM customers WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values)
    customer = Customer.new(result.first)
    return customer
  end

  def number_of_tickets
    booked_films = films
    return booked_films.length
  end

end
