module PaitinHana
  module ORM
    module ORMHelper
      def self.included base_class
        base_class.extend ClassMethods
      end

      module ClassMethods
        def table_name
          to_s.downcase.pluralizes
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

      private

      def update_placeholders(attributes = self.class.properties)
        attributes[:updated_at] = Time.now.strftime(
          "%I:%M.%S %p on %a, %b %d, %Y"
        )
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
    end
  end
end
