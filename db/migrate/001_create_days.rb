class CreateDays < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :nick, :string, :limit => 45,                  :null => false 
      t.column :password, :string, :limit => 45,              :null => false
      t.column :email, :string, :limit => 45,                 :null => false
      t.timestamps
    end
    create_table :days do |t|
      t.column :user_id,:integer,                  :null => false
      t.column :date, :date,                  :null => false
      t.column :time, :time
      t.column :first, :boolean
      t.column :temperature, :float
      t.column :intercourse, :integer
      t.column :mensing, :integer
      t.column :cervical_fluid, :integer
      t.column :cervical_appearance, :integer
      t.column :cervix_position, :integer
      t.column :cervix_opening, :integer
      t.column :cervix_texture, :integer
      t.column :disturbance, :boolean
      t.column :ovulation_pain, :boolean
      t.column :tender_breasts, :boolean
    end
    create_table :cycles do |t|
      t.column :day_id, :integer,                  :null => false
      t.column :method, :integer
      t.column :contraception, :boolean
    end
  end
  
  def self.down
    drop_table :users
    drop_table :days
    drop_table :cycles
  end
end
