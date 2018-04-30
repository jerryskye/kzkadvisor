class User < Sequel::Model
  one_to_many :logins

  def self.authenticate(creds)
    User[login: creds['login'], password: Sequel::SQL::Blob.new(Digest::SHA256.digest(creds['password']))]
  end
end
