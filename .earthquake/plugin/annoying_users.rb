path = "#{Dir.home}/.earthquake"

annoying_users = open("#{path}/annoying", 'r').read.split(/\n/).select{|i|i[/^[^#]/]}
annoying_hashtag = open("#{path}/annoying_hashtag", 'r').read.split(/\n/).select{|i|i[/^#/]}
stalking_users = open("#{path}/stalking", 'r').read.split(/\n/).select{|i|i[/^[^#]/]}

Earthquake.init do
  output :tweet do |item|
    next unless item["text"]
    annoying_flag = false

    item["text"].gsub(/(^#[^\s]+)|(#[^\s]+)/) {|i|
      if annoying_hashtag.include?(i)
        annoying_flag = true
      end
    }
    next if annoying_flag

    info = []
    if item["in_reply_to_status_id"]
      info << "(reply to #{id2var(item["in_reply_to_status_id"])})"
    elsif item["retweeted_status"]
      info << "(retweet of #{id2var(item["retweeted_status"]["id"])})"
    end
    if !config[:hide_time] && item["created_at"]
      info << Time.parse(item["created_at"]).strftime(config[:time_format])
    end
    if !config[:hide_app_name] && item["source"]
      info << (item["source"].u =~ />(.*)</ ? $1 : 'web')
    end

    id = id2var(item["id"])

    ####
    # make RT text
    text = (item["retweeted_status"] ? ">> @#{item["retweeted_status"]["user"]["screen_name"]}: #{item["retweeted_status"]["text"]}" : item["text"]).u
    raw_text = String(text)
    if config[:raw_text] && /\n/ =~ text
      text.prepend("\n")
      text.gsub!(/\n/, "\n       " + "|")
      #.c(:info))
      text << "\n      "
    else
      text.gsub!(/\s+/, ' ')
    end

    ####
    # change color
    text = text.coloring(/@[0-9A-Za-z_]+/) { |i| color_of(i) }
    text = text.coloring(/(^#[^\s]+)|(\s+#[^\s]+)/) { |i| color_of(i) }

    ####
    # expand url
    if config[:expand_url]
      entities = (item["retweeted_status"] && item["truncated"]) ? item["retweeted_status"]["entities"] : item["entities"]
      if entities
        entities.values_at("urls", "media").flatten.compact.each do |entity|
          url, expanded_url = entity.values_at("url", "expanded_url")
          if url && expanded_url
            text = text.sub(url, expanded_url)
          end
        end
      end
    end
    text = text.coloring(URI.regexp(["http", "https"]), :url)

    if item["_highlights"]
      item["_highlights"].each do |h|
        color = config[:color][:highlight].nil? ? color_of(h).to_i + 10 : :highlight
        text = text.coloring(/#{h}/i, color)
      end
    end

    mark = item["_mark"] || ""
    screen_name_display = "#{item["user"]["screen_name"].c(color_of(item["user"]["screen_name"]))}:"

    ####
    # change colors
    if item["retweeted_status"] && item["retweeted_status"]["user"]["screen_name"] == "AntiBayesian"
      text = raw_text.c(:info)
      screen_name_display = "#{item["user"]["screen_name"].c(:info)}"
    end
    if annoying_users.include?(item["user"]["screen_name"])
      text = raw_text.c(:info)
      screen_name_display = "#{item["user"]["screen_name"].c(:info)}"
    end
    if stalking_users.include?(item["user"]["screen_name"])
      screen_name_display = "@ ".c(:notice) + screen_name_display
    end

    status =  [
                "#{mark}" + "[#{id}]".c(:info),
                screen_name_display,
                "#{text}",
                (item["user"]["protected"] ? "[P]".c(:notice) : nil),
                info.join(' - ').c(:info)
              ].compact.join(" ")
    puts status
  end
end
