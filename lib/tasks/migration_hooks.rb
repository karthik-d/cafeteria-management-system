namespace :db do
  task set_role_postsgres: :environment do
    puts "Setting Role to 'postgres'"
    ActiveRecord::Base.connection.execute("SET ROLE postgres")
  end
end

Rake::Task["db:load_config"].enhance ["db:set_role_postsgres"]
