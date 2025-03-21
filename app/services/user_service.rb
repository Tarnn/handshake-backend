class UserService
  class << self
    def fetch_all_users
      Rails.logger.info("Fetching all users")
      User.all.order(:check_in_time).to_a
    end
  end
end 