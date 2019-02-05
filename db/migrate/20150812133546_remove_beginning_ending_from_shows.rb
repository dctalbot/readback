class RemoveBeginningEndingFromShows < ActiveRecord::Migration[5.2]
  def change
    [:freeform_shows, :specialty_shows, :talk_shows].each do |show_type|
      change_table show_type do |t|
        t.remove :beginning, :ending
      end
    end
  end
end
