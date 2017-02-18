class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name
      t.text :description
      t.timestamps null: false
    end

    add_column :beers, :style_id, :integer
    Beer.all.map { |b| b.style }.uniq.each { |style| Style.create name: style }

    change_table :beers do |t|
      t.rename :style, :old_style
    end

    Beer.all.each do |b|
      b.update(:style_id => Style.all.find_by(name: b.old_style).id)
    end

  end
end
