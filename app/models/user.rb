# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string           default(""), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  admin                  :boolean          default(FALSE), not null
#  locked                 :boolean          default(FALSE), not null
#  slug                   :string
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base
  # Use friendly_id on Users
  extend FriendlyId
  friendly_id :friendify, use: :slugged

  # necessary to override friendly_id reserved words
  def friendify
    if username.downcase == "admin"
      "user-#{username}"
    else
      "#{username}"
    end
  end
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Pagination
  paginates_per 100

  # Validations
  # :username
  validates :username, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /\A[a-zA-Z0-9]*\z/, on: :create, message: "can only contain letters and digits"
  validates :username, length: { in: 4..15 }
  # :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def self.paged(page_number)
    order(admin: :desc, username: :asc).page page_number
  end

  def self.search_and_order(search, page_number)
    if search
      where("username LIKE ?", "%#{search.downcase}%").order(
      admin: :desc, username: :asc
      ).page page_number
    else
      order(admin: :desc, username: :asc).page page_number
    end
  end

  def self.last_signups(count)
    order(created_at: :desc).limit(count).select("id","username","slug","created_at")
  end

  def self.last_signins(count)
    order(last_sign_in_at:
    :desc).limit(count).select("id","username","slug","last_sign_in_at")
  end

  def self.users_count
    where("admin = ? AND locked = ?",false,false).count
  end

  has_many :weigh_ins
  has_many :daily_caloric_intakes

  validates :height, presence: true
  validates :starting_weight, presence: true
  validates :target_weight, presence: true

  def  current_caloric_intake
    calories = 0
    daily_caloric_intake = daily_caloric_intakes.last

    if !daily_caloric_intake.nil?
      calories = daily_caloric_intake.calories
    end
    calories
  end

  def inches_to_cm
    height * 2.35
  end

  def lbs_to_kg
    current_weight / 2.2046
  end

  def basal_metabolic_rate
    if !current_weight.nil? && sex == "male"
    (66.47 + (13.75 * current_weight) + (5 * height) - (6.75 * age)).floor
  else
    (665.09 + (9.56 * current_weight) + (1.84 * height) - (4.67 * age)).floor
  end
  end

  def difference
    if basal_metabolic_rate > current_caloric_intake
      (basal_metabolic_rate - current_caloric_intake).floor
    else
      (current_caloric_intake - basal_metabolic_rate).floor
    end
  end

  def rest_loss_gain
    if basal_metabolic_rate > current_caloric_intake
    (3500 / difference).floor
  else
    (3500 / difference).floor
  end
  end
  
  def height_in_inches
    (feet * 12) + inches
  end


  def current_weight
    weight = 0
    weigh_in = weigh_ins.last

    if !weigh_in.nil?
      weight = weigh_in.weight
    else
      weight = starting_weight
    end

    weight
  end

  def weight_change 
    starting_weight - current_weight
  end

  def weight_to_goal
    if current_weight > target_weight
      current_weight - target_weight
    else
      target_weight - current_weight
    end
  end


  def calories_to_goal
    if current_weight > target_weight
      @deficit = current_weight - target_weight
      @cals = @deficit * 3500
    else
      @deficit = target_weight - current_weight
      @cals = @deficit * 3500
    end
  end

   def calculate_bmi
    if !current_weight.nil?
      (current_weight * 703) / height**2
    end
  end

  def previous_weight
    weight = 0
    weigh_in = weigh_ins[-2]

    if !weigh_in.nil?
      weight = weigh_in.weight
    end
    weight
  end


  def weekly_burn_to_goal
    calories_to_goal / 7
  end

  def monthly_burn_to_goal
    calories_to_goal / 30
  end

  def yearly_burn_to_goal
    calories_to_goal / 365
  end

  def cals_to_miles_ran
    calories_to_goal / 100
  end

  def miles_per_week
    cals_to_miles_ran / 7
  end

  def daily_plan_exercise
   a = (miles_per_week / 7)
   a = (a / 2)
   return a
  end

  def daily_plan_calorie
    basal_metabolic_rate * 0.95
  end

  def congratulations
    @inspirational_quotes = ['What great thing would you attempt if you knew you could not fail?','Put your heart, mind, and soul into even your smallest acts. This is the secret of success.', 'you are a fat fuck']
    if target_weight < current_weight
      @inspirational_quotes.sample
    else
      "You Did It!"
    end
  end











end
