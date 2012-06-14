module Netflix

  class << self
	  
    def configure(yml_path, logger = nil)
      @credentials ||= Netflix::Credentials.from_file(yml_path)
      @logger = logger
    end

    def credentials
      @credentials
    end
  
    def create_logger
      Logger.new(STDOUT) 
    end

    def logger
      @logger ||= create_logger 
    end

    def log(message)
      Netflix.logger.info("[#{Time.now.to_i}] #{message}")
    end  
  end # class methods
end
