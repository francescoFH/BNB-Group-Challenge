require 'pg'

class Space

  attr_reader :id, :owner, :name, :description, :price, :from_date, :to_date

  def initialize(id:, owner:, name:, description:, price:, from_date:, to_date:)
    @id = id
    @name = name
    @owner = owner
    @description = description
    @price = price
    @from_date = from_date
    @to_date = to_date
  end

  def self.create(owner:, name:, description:, price:, from_date:, to_date:)
    result = DatabaseConnection.query(
      "INSERT INTO spaces(owner, name, description, price, from_date, to_date)
      VALUES('#{owner}', '#{name}', '#{description}', #{price}, '#{from_date}', '#{to_date}')
      RETURNING id, owner, name, description, price, from_date, to_date;")

    Space.new(
      id: result[0]["id"], owner: result[0]["owner"],
      name: result[0]["name"], description: result[0]["description"],
      price: result[0]["price"], from_date: result[0]["from_date"],
      to_date: result[0]["to_date"])
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM spaces;')

    result.map do |space|
      Space.new(
        id: space['id'], owner: space['owner'],
        name: space['name'], description: space['description'],
        price: space['price'], from_date: space['from_date'],
        to_date: space['to_date'])
    end
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM spaces WHERE id = #{id};")

    Space.new(
      id: result[0]["id"], owner: result[0]["owner"],
      name: result[0]["name"], description: result[0]["description"],
      price: result[0]["price"], from_date: result[0]["from_date"],
      to_date: result[0]["to_date"])
  end

  def self.available(from_date:, to_date:)
    # if :from_date == ""
    #   result = DatabaseConnection.query("SELECT * FROM spaces;")
    # else
      result = DatabaseConnection.query("SELECT * FROM spaces WHERE from_date >= '#{from_date}' AND to_date <= '#{to_date}';")
    # end
      result.map do |space|
        Space.new(
          id: space['id'], owner: space['owner'],
          name: space['name'], description: space['description'],
          price: space['price'], from_date: space['from_date'],
          to_date: space['to_date'])
      end
  end
end
