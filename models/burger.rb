require ('pg')
require_relative ('../db/sql_runner')

class Burger

  attr_accessor :name, :restaurant_id, :deal, :day_id
  attr_reader :id

  def initialize (options)
    @id = options["id"].to_i
    @name = options["name"]
    @restaurant_id = options ["restaurant_id"]
    @deal = options ["deal"]
    @day_id = options["day_id"]
  end

  def save()
    sql = "INSERT INTO burgers ( name, restaurant_id, deal, day_id ) VALUES ( '#{@name}', #{@restaurant_id}, '#{@deal}', #{@day_id} ) RETURNING *;"
    result = SqlRunner.run(sql)
    @id = result[0]["id"].to_i
  end

  def day_available()
    sql = "SELECT * FROM days WHERE id = #{@day_id};"
    result = SqlRunner.run(sql)
    return result[0]["name"]
  end

  def delete(id)
    sql = "DELETE FROM burgers WHERE id = #{id};"
    SqlRunner.run(sql)
  end

  def restaurant()
    sql = "SELECT * FROM restaurants WHERE id = #{@restaurant_id};"
    result = SqlRunner.run(sql)
    return result[0]
  end


  def self.all()
    sql = "SELECT * FROM burgers;"
    result = SqlRunner.run(sql)
    burgers = result.map{|hash|Burger.new(hash)}
  end

  def self.find(id)
    sql = "SELECT * FROM burgers WHERE id = #{id};"
    burger = SqlRunner.run(sql)
    result = Burger.new(burger[0])
  end

  def self.update(options)
    sql = "UPDATE burgers SET
          name = '#{options['name']}',
          restaurant_id = '#{options['restaurant_id']}',
          deal = '#{options['deal']}',
          day_id = '#{options['day_id']}'
          WHERE id = '#{options['id']}';"
   SqlRunner.run(sql)
  end



  def self.delete(id)
    sql = "DELETE FROM burgers WHERE id = #{id};"
    SqlRunner.run(sql)
  end

  def self.day_sort(day_id)
    sql = "SELECT * FROM burgers WHERE day_id = #{day_id}"
    burger_hash = SqlRunner.run(sql)
    result = burger_hash.map{|hash|Burger.new(hash)}
  end
  
end

