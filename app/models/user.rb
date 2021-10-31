class User < ApplicationRecord
  include AuthenticationToken
  include ExportToCsv

  attr_accessor :skip_password_validation

  devise :database_authenticatable, :registerable, :validatable,
    :password_expirable, :recoverable, :rememberable

  has_many :student_volunteer_assignments, inverse_of: :volunteer, foreign_key: :volunteer_id
  has_many :students, through: :student_volunteer_assignments

  has_many :student_staff_assignments, inverse_of: :staff, foreign_key: :staff_id
  has_many :managed_students, through: :student_staff_assignments, source: :student

  has_many :survey_responses
  has_many :support_tickets, foreign_key: :requestor_id

  validates :first_name, :last_name, presence: true

  enum status: {active: 0, inactive: 1}
  enum role: {volunteer: 0, admin: 1}

  def active_for_authentication?
    super && active?
  end

  def name
    "#{first_name} #{last_name}"
  end

  def initials
    first_name[0] + last_name[0]
  end

  def password_required?
    return false if skip_password_validation
    super
  end

  def deactivate!(deactivator_id:)
    self.deactivated_at = Time.now
    self.deactivator_id = deactivator_id
    self.status = :inactive
    save!
  end

  def activate!
    self.status = :active
    save!
  end

  def last_seen
    survey_responses.maximum(:updated_at)
  end

  def completed_surveys
    survey_responses.where(status: :complete)
  end
end
