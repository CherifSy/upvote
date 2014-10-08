class Authorization < ActiveRecord::Base
  serialize :meta, JSON
  belongs_to :user

  validates :uid,      presence: true, uniqueness: { scope: :provider }
  validates :provider, presence: true, inclusion: User.omniauth_providers.map(&:to_s)

  def self.find_for_oauth(auth)
    find_or_initialize_by uid: auth.uid, provider: auth.provider
  end

end
