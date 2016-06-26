require "sqlite3"

module PaitinHana
  module ORM
    class Database
      def self.connect
        SQLite3::Database.new(File.join(ROOT_FOLDER, "db", "app.db"))
      end
    end
  end
end
