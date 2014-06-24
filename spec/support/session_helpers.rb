module Features
  module SessionHelpers
    def sign_in_admin_user
      admin = current_admin_user
      login_as admin, scope: :admin_user
    end

    def admin_password
      "skj30kx01%^"
    end

    def current_admin_user
      @current_admin_user ||= AdminUser.create!(email: "admin@example.com",
                                                password: admin_password)
    end
  end
end
