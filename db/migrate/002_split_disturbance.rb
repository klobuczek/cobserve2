class SplitDisturbance < ActiveRecord::Migration
  def self.up
    add_column :days, :fever, :boolean
    add_column :days, :lack_of_sleep, :boolean
    execute 'update days set fever = true where disturbance = 1'
    execute 'update days set lack_of_sleep = true where disturbance = 2'
#    Day.reset_column_information
#    Day.find(:all).each do |d|
#      d.update_attributes! :fever => (d.disturbance == 1), :lack_of_sleep => (d.disturbance == 2)
#    end
    remove_column :days, :disturbance  
  end
  
  def self.down
    add_column :days, :disturbance, :integer
    execute 'update days set disturbance = 1 where fever'
    execute 'update days set disturbance = 2 where lack_of_sleep'
#    Day.reset_column_information
#    Day.find(:all).each do |d|
#      d.update_attribute :disturbance, d.fever ? 1 : d.lack_of_sleep ? 2 : nil
#    end
    remove_column :days, :fever
    remove_column :days, :lack_of_sleep
  end
end
