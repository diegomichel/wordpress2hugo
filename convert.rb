#!/usr/bin/ruby
require 'pry'
require 'reverse_markdown'
require 'mysql'
# remember to execute first gem install mysql
db_host='localhost'
db_username='root'
db_password='1'
db_database='diegomichel_org'
db_posts_table='wp_m3yqzy_posts'
begin
    con = Mysql.new db_host, db_username, db_password
    con.select_db db_database
    rs = con.query "select post_name, post_status, post_title, post_content, post_date from #{db_posts_table}"
    rs.each do |row|
      post_content = ReverseMarkdown.convert row[3]
      binding.pry
    end

rescue Mysql::Error => e
    puts e.errno
    puts e.error

ensure
    con.close if con
end
