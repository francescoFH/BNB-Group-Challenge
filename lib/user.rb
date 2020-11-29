require_relative './database_connection'
require 'bcrypt'

class User

  attr_reader :id, :name, :email, :requests

  def initialize(id:, name:, email:)
    @id = id
    @name = name
    @email = email
    @requests = [
      {
        "test" => "House_test",
        "name" => "Mr Test",
        "email" => "test@email.com"
      }
    ]
  end

  def self.create(name:, email:, password:)
    encrypted_password = BCrypt::Password.create(password)
    search = DatabaseConnection.query(
      "SELECT *
       FROM users
       WHERE email = '#{email}';"
      )

    return unless search.none?

    user = DatabaseConnection.query(
      "INSERT INTO users (name, email, password)
       VALUES('#{name}', '#{email}', '#{encrypted_password}')
       RETURNING id, name;"
      )
    User.new(id: user[0]['id'], name: user[0]['name'], email: user[0]['email'])
  end

  def self.find(id:)
    return nil unless id

    search = DatabaseConnection.query(
      "SELECT *
        FROM users
       WHERE id = #{id};"
      )

    User.new(id: search[0]['id'], name: search[0]['name'], email: search[0]['email'])
  end

  def self.authenticate(email:, password:)
    result = DatabaseConnection.query(
      "SELECT *
      FROM users
      WHERE email = '#{email}'"
     )

    return unless result.any?

    return unless BCrypt::Password.new(result[0]['password']) == password

    User.new(id: result[0]['id'], name: result[0]['name'], email: result[0]['email'])
  end

  def book(request)
    @requests << request
  end
end
