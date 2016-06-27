class Todo < PaitinHana::ORM::BaseModel
  property :id, type: :integer, primary_key: true
  property :title, type: :text, nullable: false
  property :todo, type: :text, nullable: false
  property :status, type: :text, nullable: false
  property :created_at, type: :text, nullable: false
  property :updated_at, type: :text, nullable: false
  create_table
end
