require_relative('../model/customer')
require_relative('../model/ticket')
require_relative('../model/film')
require_relative('../model/screening')
require('pry-byebug')

customer1 = Customer.new({'name' => 'Digory', 'funds' => '30.00'})
customer1.save

customer2 = Customer.new({'name' => 'Marcin', 'funds' => '15.70'})
customer2.save
customer3 = Customer.new({'name' => 'Mike', 'funds' => '14.70'})
customer3.save
customer4 = Customer.new({'name' => 'Joanna', 'funds' => '12.70'})
customer4.save
customer5 = Customer.new({'name' => 'Raphael', 'funds' => '14.70'})
customer5.save
customer6 = Customer.new({'name' => 'Beata', 'funds' => '15.70'})
customer6.save
customer7 = Customer.new({'name' => 'Emil', 'funds' => '15.70'})
customer7.save
customer8 = Customer.new({'name' => 'Emil', 'funds' => '15.70'})
customer8.save
film1 = Film.new({'title' => 'Snatch', 'price' => '13.50'})
film2 = Film.new({'title' => 'Pokemons', 'price' => '10'})
film1.save
film2.save
# film1.delete
screening1 = Screening.new({'show_time' => '12.30', 'film_id' => film1.id})
screening1.save
screening2 = Screening.new({'show_time' => '13.30', 'film_id' => film1.id})
screening2.save
screening3 = Screening.new({'show_time' => '18.30', 'film_id' => film2.id})
screening3.save
p screening3.find_price
customer1.buy_ticket(screening1)
customer2.buy_ticket(screening1)
customer3.buy_ticket(screening1)
customer4.buy_ticket(screening1)
# ticket1 = Ticket.new({'customer_id' => customer1.id, 'screening_id' => screening1.id})
# ticket1.save
# ticket2 = Ticket.new({'customer_id' => customer2.id, 'screening_id' => screening1.id})
# ticket2.save
# ticket3 = Ticket.new({'customer_id' => customer5.id, 'screening_id' => screening3.id})
# ticket3.save
# ticket4 = Ticket.new({'customer_id' => customer3.id, 'screening_id' => screening2.id})
# ticket4.save
# ticket5 = Ticket.new({'customer_id' => customer4.id, 'screening_id' => screening1.id})
# ticket5.save
# ticket6 = Ticket.new({'customer_id' => customer5.id, 'film_id' => film1.id, 'screening_id' => screening2.id})
# ticket6.save
# ticket6 = Ticket.new({'customer_id' => customer6.id, 'film_id' => film2.id, 'screening_id' => screening1.id})
# ticket6.save
# ticket7 = Ticket.new({'customer_id' => customer7.id, 'film_id' => film2.id, 'screening_id' => screening2.id})
# ticket7.save
# ticket7 = Ticket.new({'customer_id' => customer8.id, 'film_id' => film2.id, 'screening_id' => screening2.id})
# ticket7.save
# p film2.most_popular_show_time
