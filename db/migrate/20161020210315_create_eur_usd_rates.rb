class CreateEurUsdRates < ActiveRecord::Migration
  def change
    create_table :eur_usd_rates do |t|
      t.string :date
      t.decimal :currency, precision: 6, scale: 4

      t.timestamps
    end
    add_index :eur_usd_rates, :date
  end
end
