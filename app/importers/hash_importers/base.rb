module HashImporters
  # HashImporters should inherit from this class and define the constants
  class Base
    def self.import(hash)
      attributes = hash.slice(*self::ATTS)
      log_model_creation(attributes)
    end

    def self.import_each(hash, key, importer, item_overrides = {})
      hash[key]&.map do |item_hash|
        full_hash = item_hash.merge(item_overrides)
        importer.import(full_hash)
      end
    end

    def self.log_model_creation(attributes)
      header = self::MESSAGES[:header]
      success = self::MESSAGES[:success]
      failure = self::MESSAGES[:failure]

      puts "----- #{header} -------" if header.present?
      new_model = self::MODEL.new(attributes)
      new_model.save ? (puts success) : (puts failure)
      new_model
    end
  end
end
