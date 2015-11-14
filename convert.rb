# encoding: UTF-8
#!/usr/bin/ruby
require 'pry'
require 'reverse_markdown'
require 'mysql2'
require 'fileutils'
# remember to execute first gem install mysql
db_host='localhost'
db_username='root'
db_password='1'
db_database='diegomichel_org'
db_posts_table='wp_m3yqzy_posts'
destination='old_blog'
FileUtils::mkdir_p destination
client = Mysql2::Client.new(host: db_host, username: db_username, password: db_password, database: db_database)
rs = client.query "select post_date, post_status, post_title, post_content from #{db_posts_table}"
rs.each(as: :array) do |row|
  row[0] = row[0]
  p row[0].inspect
  next if row[1] == 'inherit'
  post_content = ReverseMarkdown.convert row[3].encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
  post =<<-END.gsub(/^ {6}/, '')
        +++
        date = "#{row[0]}"
  #{'draft = true' if row[1] == 'draft'}
        title = "#{row[2]}"
        slug = "#{row[2].gsub(/[^0-9a-z ]/i, '').tr(' ', '-').downcase}"
        +++
  #{post_content}
  END
end
