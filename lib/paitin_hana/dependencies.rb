class Object
  def self.const_missing(name)
    require name.to_s.snake_case
    const_get name
  rescue LoadError
  end
end
