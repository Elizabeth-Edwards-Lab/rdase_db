namespace :db_cleanup do

    desc "Finds unused database tables and fields"
    task :run => :environment do
        connection = ActiveRecord::Base.connection
        connection.tables.collect do |t|
            count = connection.select_all("SELECT count(1) as count FROM #{t}", "Count").first['count']
            
            puts "TABLE EMPTY #{t}" if count.to_i == 0
            
            columns = connection.columns(t).collect(&:name).reject {|x| x == 'id' }
            columns.each do |column|
                values = connection.select_all("SELECT DISTINCT('#{column}') AS val FROM #{t} LIMIT 2", "Distinct Check")
                if values.length == 1
                    if values.first['val'].nil?
                        puts "COLUMN EMPTY #{t}:#{column}"
                    else
                        puts "COLUMN SINGLE VALUE #{t}:#{column} -- #{values.first['val']}"
                    end
                end
            end
        end
    end    
end