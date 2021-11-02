# модель - объект для которого будут строится цепочки диспозиций
class AstroObject < ActiveRecord::Base
  validates :name, presence: true
  has_many :chains, dependent: :destroy
  acts_as_taggable

  def self.find_by_name(name)
    self.where('name LIKE ? OR name LIKE ? OR name LIKE ?', 
              "%#{name.mb_chars.capitalize.to_s}%", 
              "%#{name.mb_chars.downcase.to_s}%",
              "%#{name.mb_chars.upcase.to_s}%")
  end
end
