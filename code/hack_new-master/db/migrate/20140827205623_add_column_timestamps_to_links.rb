class AddColumnTimestampsToLinks < ActiveRecord::Migration
  def change
    add_timestamps(:links)
  end
end
