require 'rubygems'
require 'posterous'
require 'time'

# Add your credentials Here
Posterous.config = {
  'username'  => 'olalonde@gmail.com',
  'password'  => 'blop123',
  'api_token' => 'gzGzGGlvfGhIlzacIqqxqhvdyJvydvwf',
}

include Posterous

def parse_date str
  DateTime.parse( str ).strftime('%Y-%m-%d %H:%M:%S')
end

def xml_template items
  '<?xml version="1.0" encoding="UTF-8"?>
    <rss version="2.0"
      xmlns:content="http://purl.org/rss/1.0/modules/content/"
      xmlns:dsq="http://www.disqus.com/"
      xmlns:dc="http://purl.org/dc/elements/1.1/"
      xmlns:wp="http://wordpress.org/export/1.0/">
      <channel>' + items + '</channel>
    </rss>'
end

def comment_template comment
  "<wp:comment>
     <wp:comment_id>#{comment.id}</wp:comment_id>
     <wp:comment_author>#{comment.name || comment.user['display_name']}</wp:comment_author>
     <wp:comment_author_email></wp:comment_author_email>
     <wp:comment_author_url></wp:comment_author_url>
     <wp:comment_author_IP></wp:comment_author_IP>
     <wp:comment_date_gmt>#{parse_date( comment.created_at )}</wp:comment_date_gmt>
     <wp:comment_content><![CDATA[#{ comment.body}]]></wp:comment_content>
     <wp:comment_approved>1</wp:comment_approved>
     <wp:comment_parent>0</wp:comment_parent>
   </wp:comment>"
end

def item_template item
  "<item>
     <title>#{ item[:title] }</title>
     <link>#{ item[:url] }</link>
     <dsq:thread_identifier></dsq:thread_identifier>
     <wp:post_date_gmt>#{ item[:date] }</wp:post_date_gmt>
     <wp:comment_status>open</wp:comment_status>
     #{item[:comments]}
   </item>"
end

def process_blog
  items = ''
  Site.primary.posts.each { |post|
    item = {
      :url      => post.full_url,
      :title    => post.title,
      :date     => parse_date( post.display_date ),
      :comments => post.comments.map { |comment| comment_template(comment) }.join(' ')
    }
    items += item_template( item )
  }
  puts xml_template( items )
end

process_blog()
