module PaitinHana
  module ORM
    module ORMHelper
      def self.included base
        base.extend ClassMethods
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

      module ClassMethods
        def all
          query = "SELECT * FROM #{table_name} ORDER BY id DESC"
          result = db.execute query
          result.map { |row| find_object(row) }
        end

        def find id
          row = db.execute(
            "SELECT * from #{table_name} WHERE id= ?", "#{id}"
          ).first
          row.nil? ? nil : find_object row
        end

        def self.count
          result = db.execute "SELECT COUNT(*) FROM #{table_name}"
          result.first.first
        end

        def self.destroy(id)
          db.execute "DELETE FROM #{table_name} WHERE id= ?", id
        end

        def destroy_all
          db.execute "DELETE FROM #{table_name}"
        end
      end
    end
  end
end
