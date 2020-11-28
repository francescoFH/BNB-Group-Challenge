require_relative './database_connection'
require 'bcrypt'

class User

  attr_reader :id, :name

  def initialize(id:, name:)
    @id = id
    @name = name
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
    User.new(id: user[0]['id'], name: user[0]['name'])
  end

  def self.find(id:)
    return nil unless id

    search = DatabaseConnection.query(
      "SELECT *
        FROM users
       WHERE id = #{id};"
      )

    User.new(id: search[0]['id'], name: search[0]['name'])
  end

  def self.authenticate(email:, password:)
    result = DatabaseConnection.query(
      "SELECT *
      FROM users
      WHERE email = '#{email}'"
     )

    return unless result.any?

    return unless BCrypt::Password.new(result[0]['password']) == password

    User.new(id: result[0]['id'], name: result[0]['name'])
  end

end
