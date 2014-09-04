class Partner < ActiveRecord::Base
  include Initializer

  after_initialize :set_status, :set_start_date
  before_create :generate_osra_num

  validates :name, presence: true, uniqueness: true
  validates :province, presence: true
  validates :start_date, date_not_in_future: true

  belongs_to :province
  belongs_to :status

  acts_as_sequenced scope: :province_id

  private

  def generate_osra_num
    self.osra_num = province.code.to_s + "%03d" % sequential_id
  end
end
