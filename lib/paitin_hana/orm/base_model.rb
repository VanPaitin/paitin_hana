require_relative "orm_helper"

module PaitinHana
  module ORM
    class BaseModel
      extend PaitinHana::ORM::ORMHelper

      def initialize(attributes = {})
        attributes.each { |column, value| send("#{column}=", value) }
      end

      class << self
        attr_accessor :properties, :db
        def all
          query = "SELECT * FROM #{table_name} ORDER BY id DESC"
          result = db.execute query
          result.map { |row| find_object(row) }
        end

        def find(id)
          row = db.execute(
            "SELECT * from #{table_name} WHERE id= ?", "#{id}"
          ).first
          row.nil? ? nil : find_object(row)
        end

        def count
          result = db.execute "SELECT COUNT(*) FROM #{table_name}"
          result.first.first
        end

        def create(attributes)
          object = new(attributes)
          object.save
          id = db.execute "SELECT last_insert_rowid()"
          object.id = id.first.first
          object
        end

        [%w(last DESC), %w(first ASC)].each do |method_name_and_order|
          define_method((method_name_and_order[0]).to_s.to_sym) do
            query = "SELECT * FROM #{table_name} ORDER BY "\
            "id #{method_name_and_order[1]} LIMIT 1"
            row = db.execute query
            find_object(row.first) unless row.empty?
          end
        end

        def destroy(id)
          db.execute "DELETE FROM #{table_name} WHERE id= ?", id
        end

        def destroy_all
          db.execute "DELETE FROM #{table_name}"
        end
      end

      def save
        table = self.class.table_name
        query = if id
                  "UPDATE #{table} SET #{update_placeholders} WHERE id = ?"
                else
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

      def update_placeholders(attributes = self.class.properties)
        columns = attributes.keys
        columns.delete(:id)
        columns.map { |column| "#{column}= ?" }.join(", ")
      end

      def update_values(attributes)
        attributes.values << id
      end

      def record_placeholders
        (["?"] * (self.class.properties.keys.size - 1)).join(",")
      end

      def record_values
        column_names = self.class.properties.keys
        column_names.delete(:id)
        column_names.map { |column_name| send(column_name) }
      end

      def destroy
        table = self.class.table_name
        self.class.db.execute "DELETE FROM #{table} WHERE id= ?", id
      end
    end
  end
end
