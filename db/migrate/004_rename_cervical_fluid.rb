class RenameCervicalFluid < ActiveRecord::Migration
  def self.up
    rename_column :days, :cervical_fluid,      :cervical_fluid_feeling
    rename_column :days, :cervical_appearance, :cervical_fluid_appearance
  end

  def self.down
    rename_column :days, :cervical_fluid_feeling,    :cervical_fluid
    rename_column :days, :cervical_fluid_appearance, :cervical_appearance
  end
end
