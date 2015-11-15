# encoding: UTF-8
#!/usr/bin/ruby
require 'reverse_markdown'
require 'mysql2'
require 'fileutils'
#####Configuration#####
db_host = 'localhost'
db_username = 'root'
db_password = '1'
db_database = 'diegomichel_org'
db_posts_table = 'wp_m3yqzy_posts'
destination = 'old_blog_posts/' # make sure includes the slash at the end.
######################
FileUtils.mkdir_p destination
client = Mysql2::Client.new(host: db_host,
                            username: db_username,
                            password: db_password,
                            database: db_database)
rs = client.query "select post_date, post_status, post_title, post_content from #{db_posts_table}"
count = 0
rs.each(as: :array) do |row|
  next if row[1] == 'inherit'
  count += 1
  post_content = ReverseMarkdown.convert row[3].encode('UTF-8',
                                                       'binary',
                                                       invalid: :replace,
                                                       undef: :replace,
                                                       replace: '')
  slug = row[2].gsub(/[^0-9a-z ]/i, '').tr(' ', '-').downcase
  post = <<-END.gsub(/^ {6}/, '')
      +++
      date = "#{row[0].to_date.to_s}"#{"\n      draft = true" if row[1] == 'draft'}
      title = "#{row[2].tr("\"","'")}"
      +++
      #{post_content}
  END
  File.open("#{destination}#{count}-#{slug}.md", 'w') { |f| f.write(post) }
end
