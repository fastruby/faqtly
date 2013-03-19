Sequel.migration do
  up do
    add_column :questions, :description, String
    add_column :questions, :keywords, String
  end

  down do
    drop_column :questions, :keywords
    drop_column :questions, :description
  end
end
