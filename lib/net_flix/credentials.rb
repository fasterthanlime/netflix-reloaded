module Netflix
  class Credentials < Valuable

    has_value :key
    has_value :secret
    has_value :access_token
    
    def valid?
      (key && secret) != nil
    end
    
    class << self

      def from_file(yml_path)
        new(YAML.load(File.read(yml_path)))
      end

    end # class methods

    def to_yaml
      attributes.to_yaml
    end
  end

end
