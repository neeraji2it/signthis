class AddDetourMeetingsToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :third_detour_meeting, :boolean, default: false
    add_column :documents, :fourth_detour_meeting, :boolean, default: false
    add_column :documents, :third_detour_meeting_description, :text
    add_column :documents, :fourth_detour_meeting_description, :text
  end
end
