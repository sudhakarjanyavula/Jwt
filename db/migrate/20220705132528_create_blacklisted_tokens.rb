class CreateBlacklistedTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :blacklisted_tokens do |t|
      t.string :jti
      t.datetime :exp

      t.timestamps
    end
    add_index :blacklisted_tokens, :jti, unique: true
  end
end
