class RenameMethod < ActiveRecord::Migration
  def self.up
    rename_column :cycles, :method, :reading
  end

  def self.down
    rename_column :cycles, :reading, :method
  end
end
