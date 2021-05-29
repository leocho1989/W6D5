class User < ApplicationRecord
    validates :user_name, session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true

    after_initialize :ensure_session_token

    def reset_session_token!
        
    end
end