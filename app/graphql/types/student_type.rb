module Types
  class StudentType < Base::Object
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: true
    field :nickname, String, null: true
    field :date_of_birth, GraphQL::Types::ISO8601DateTime, null: true
    field :initials, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
