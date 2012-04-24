class RestfulAuthentication < ActiveRecord::Migration
  def self.up
    rename_column :users, :nick,      :login
    rename_column :users, :password,  :crypted_password
    
    change_column :users, :login,             :string, :limit => 40,  :null => false
    change_column :users, :email,             :string, :limit => 100, :null => false
    change_column :users, :crypted_password,  :string, :limit => 40,  :null => false
    
    add_column :users, :salt,                      :string, :limit => 40
    add_column :users, :remember_token,            :string
    add_column :users, :remember_token_expires_at, :datetime
    
    User.reset_column_information
    User.find(:all).each do |u|
      u.update_attributes! :salt => Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{u.login}--"),
                          :password => u.login, 
                          :password_confirmation => u.login
    end
  end
  
  def self.down
    rename_column :users, :login,             :nick
    rename_column :users, :crypted_password,  :password
    
    remove_column :users, :salt
    remove_column :users, :remember_token
    remove_column :users, :remember_token_expires_at
  end
end
