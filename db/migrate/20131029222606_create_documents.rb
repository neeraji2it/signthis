class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer  "architect_id"
      t.string   "first_spouse_first_name"
      t.string   "first_spouse_last_name"
      t.string   "second_spouse_first_name"
      t.string   "second_spouse_last_name"
      t.boolean  "foundation_building",                      default: true,             null: false
      t.boolean  "parenting_planning_i",                     default: true,             null: false
      t.boolean  "fiscal_mapping",                           default: true,             null: false
      t.boolean  "document_prepping",                        default: true,             null: false
      t.boolean  "final_review",                             default: true,             null: false
      t.boolean  "parenting_planning_ii",                    default: true,             null: false
      t.boolean  "fiscal_mapping_ii",                        default: true,             null: false
      t.boolean  "parenting_planning_iii",                   default: false,            null: false
      t.boolean  "fiscal_mapping_iii",                       default: false,            null: false
      t.boolean  "first_spouse_detour_meeting",              default: false,            null: false
      t.text     "first_spouse_detour_meeting_description"
      t.boolean  "second_spouse_detour_meeting",             default: false,            null: false
      t.text     "second_spouse_detour_meeting_description"
      t.string   "price"
      t.text     "terms"
      t.text     "first_signature",                          default: "{\"lines\":[]}"
      t.text     "second_signature",                         default: "{\"lines\":[]}"
      t.datetime "first_signature_updated_at"
      t.datetime "second_signature_updated_at"
      t.boolean  "waiting_for_first_signature",              default: false
      t.boolean  "waiting_for_second_signature",             default: false
      
      t.timestamps
    end
  end
end
