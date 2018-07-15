require_relative('../db/sql_runner')
require_relative('customer')
require_relative('screening')
class Ticket
  attr_accessor :customer_id, :film_id
  def initialize options
    @id = options['id']
    @customer_id = options['customer_id']
    @screening_id = options['screening_id']
  end

  def save
    sql = "INSERT INTO tickets (customer_id, screening_id) VALUES ($1, $2) RETURNING id;"
    values = [@customer_id, @screening_id]
    result = SqlRunner.run(sql, values)
    @id = result.first['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM tickets"
    result = SqlRunner.run(sql)
    tickets = result.map {|ticket| Ticket.new(ticket)}
    return tickets
  end

  def update
    sql = "UPDATE tickets SET (customer_id, film_id, screening_id) = ($1, $2) WHERE id = $4;"
    values = [@customer_id, @screening_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM tickets WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end


end
