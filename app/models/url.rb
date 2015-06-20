class Url < ActiveRecord::Base
  before_save { self.short_url = short_url.downcase }
  before_save { self.long_url = long_url.downcase }
    
  VALID_URL_REGEX = /\A((http|https):\/\/)?[a-z0-9]+([\-\.]
                      {1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
                      
  BAD_WORDS_REGEX = /foo|bar/i                    
                        
  validates :long_url,  presence: true, uniqueness: { case_sensitive: false },
                    format: { with: VALID_URL_REGEX }
                      
  validates :short_url, uniqueness: { case_sensitive: false },
                    length: { maximum: 10 },
                    format: { without: BAD_WORDS_REGEX }
        
end
