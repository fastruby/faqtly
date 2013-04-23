namespace :tddium do
  desc "load database extensions"
  task db_hook: :environment do

    Rake::Task["pre_test"].invoke
    
    # Kernel.system("psql #{ENV['TDDIUM_DB_NAME']} -c 'CREATE EXTENSION hstore;'")
 
    # Rake::Task["tddium:default_db_hook"].invoke

    
  end
end