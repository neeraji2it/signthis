class Link < ActiveRecord::Base
  belongs_to :document

  validates :key, uniqueness: true, presence: true

  after_initialize :generate_key, unless: :key_present?

  private

  def generate_key
    self.key = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Link.exists?(key: random_token)
    end
  end

  def key_present?
    key.present?
  end

end
