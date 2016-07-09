module PaitinHana
  module ORM
    module ORMHelper
      def create_table
        @db ||= PaitinHana::ORM::Database.connect
        query = <<-TABLE
        CREATE TABLE IF NOT EXISTS #{table_name} (
          #{table_fields.join(', ')}
        )
        TABLE
        db.execute(query)
      end

      def table_name
        to_s.downcase.pluralizes
      end

      def property(column_name, info)
        @properties ||= {}
        unless @properties.keys.include? :updated_at
          @properties[:created_at] = { type: :text, nullable: false }
          @properties[:updated_at] = { type: :text, nullable: false }
          attr_accessor :created_at, :updated_at
        end
        @properties[column_name] = info
        attr_accessor column_name
      end

      def table_columns
        columns = @properties.keys
        columns.delete(:id)
        columns.map(&:to_s).join(", ")
      end

      def table_fields
        fields = []
        @properties.each do |column, info|
          property_field = []
          property_field << column
          analyze_info property_field, info
          fields << property_field.join(" ")
        end
        fields
      end

      def analyze_info(property_field, info)
        info.each do |key, value|
          property_field << send(key, value)
        end
      end

      def type(value)
        value.to_s
      end

      def primary_key(value)
        "PRIMARY KEY AUTOINCREMENT" if value
      end

      def nullable(value)
        "NOT NULL" unless value
      end

      def find_object(row)
        return nil unless row
        object = new
        properties.keys.each_with_index do |key, index|
          object.send("#{key}=", row[index])
        end
        object
      end
    end
  end
end
