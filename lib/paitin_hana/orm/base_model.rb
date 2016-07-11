require_relative "orm_helper"

module PaitinHana
  module ORM
    class BaseModel
      include PaitinHana::ORM::ORMHelper

      class << self
        attr_accessor :properties, :db
      end

      def initialize(attributes = {})
        attributes.each { |column, value| send("#{column}=", value) }
      end

      def self.create_table
        @db ||= PaitinHana::ORM::Database.connect
        query = <<-TABLE
        CREATE TABLE IF NOT EXISTS #{table_name} (
          #{table_fields.join(', ')}
        )
        TABLE
        db.execute(query)
      end

      def self.property(column_name, info)
        @properties ||= {}
        unless @properties.keys.include? :updated_at
          @properties[:created_at] = { type: :text, nullable: false }
          @properties[:updated_at] = { type: :text, nullable: false }
          attr_accessor :created_at, :updated_at
        end
        @properties[column_name] = info
        attr_accessor column_name
      end

      def self.all
        query = "SELECT * FROM #{table_name} ORDER BY id DESC"
        result = db.execute query
        result.map { |row| find_object(row) }
      end

      def self.find(id)
        row = db.execute(
          "SELECT * from #{table_name} WHERE id= ?", "#{id}"
        ).first
        row.nil? ? nil : find_object(row)
      end

      def self.count
        result = db.execute "SELECT COUNT(*) FROM #{table_name}"
        result.flatten.first
      end

      def self.create(attributes)
        object = new(attributes)
        object.save
        id = db.execute "SELECT last_insert_rowid()"
        object.id = id.first.first
        object
      end

      def self.destroy(id)
        db.execute "DELETE FROM #{table_name} WHERE id= ?", id
      end

      def self.destroy_all
        db.execute "DELETE FROM #{table_name}"
      end

      [%w(last DESC), %w(first ASC)].each do |method_name_and_order|
        define_singleton_method(method_name_and_order[0]) do
          query = "SELECT * FROM #{table_name} ORDER BY "\
          "id #{method_name_and_order[1]} LIMIT 1"
          row = db.execute query
          find_object(row.first) unless row.empty?
        end
      end

      def save
        table = self.class.table_name
        query = if id
                  "UPDATE #{table} SET #{update_placeholders} WHERE id = ?"
                else
                  self.updated_at = self.created_at = Time.now.strftime(
                    "%I:%M.%S %p on %a, %b %d, %Y"
                  )
                  "INSERT INTO #{table} (#{self.class.table_columns}) VALUES "\
                  "(#{record_placeholders})"
                end
        values = id ? record_values << send("id") : record_values
        self.class.db.execute query, values
      end

      alias save! save

      def update(attributes)
        table = self.class.table_name
        query = "UPDATE #{table} SET #{update_placeholders(attributes)}"\
        " WHERE id= ?"
        self.class.db.execute(query, update_values(attributes))
      end

      def destroy
        self.class.destroy id
      end
    end
  end
end
