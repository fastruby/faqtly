namespace :tddium do
  desc "load database extensions"
  task :db_hook do
    Rake::Task["db:create"].invoke
 
    Kernel.system("psql #{ENV['TDDIUM_DB_NAME']} -c 'CREATE EXTENSION hstore;'")
 
    Rake::Task["tddium:default_db_hook"].invoke

    Rake::Task["sq:reset"].invoke
  end
end