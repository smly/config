# -*- coding: utf-8 -*-
require 'base64'

path = "#{Dir.home}/.earthquake"

annoying_users = open("#{path}/annoying", 'r').read.split(/\n/).select{|i|i[/^[^#]/]}
annoying_hashtag = open("#{path}/annoying_hashtag", 'r').read.split(/\n/).select{|i|i[/^#/]}
stalking_users = open("#{path}/stalking", 'r').read.split(/\n/).select{|i|i[/^[^#]/]}

#######################

retweet_antibayesian_filter = Proc.new do |item, text|
  item["retweeted_status"] && item["retweeted_status"]["user"]["screen_name"] == "AntiBayesian"
end

#######################

spam_filter = Proc.new do |item, text|
  text =~ /http:\/\/matome\.naver\.jp/
end

#######################

hatebu_filter_users = Base64.decode64("b3Zlcmxhc3Q=\n").split(' ')
hatebu_filter_pattern = Regexp.compile("http:\/\/htn\.to/")
hatebu_filter = Proc.new do |item, text|
  hatebu_filter_users.include?(item["user"]["screen_name"]) && hatebu_filter_pattern.match(text)
end

#######################

kancolle_keywords = <<EOF
羅針盤
陣
提督
ボス
弾薬
単縦
中破
大破
海域
勝利
初撃
夜戦
出撃
空母
矢矧
建造
ドロップ
カットイン
仕置き
敵
軽巡
艦
[0-5]-[0-5]-[0-5]
[A-Z]-[0-9]
[A-Z][0-9]
[0-9]+戦
Lv[0-9]{2}
三回目
轟沈
戦闘
駆逐
遠征
練習航海
比叡
艦隊
レア
矢矧
大和
武蔵
長門
金剛
舞風
島風
家具箱
EOF

kancolle_gamers = Base64.decode64("dGFuYWtoIGRlY2ltYWxibG9hdCBtZXNvdGFiaSByZXBlYXRlZGx5\n").split(' ')
kancolle_pattern = Regexp.compile("(" + kancolle_keywords.split("\n").join(")|(") + ")")

kancolle_filter = Proc.new do |item, text|
  kancolle_gamers.include?(item["user"]["screen_name"]) && kancolle_pattern.match(text)
end

#######################
#######################

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

    ### Filter annoying tweets
    if kancolle_filter.call(item, text)
      next
    end
    if hatebu_filter.call(item, text)
      next
    end
    if spam_filter.call(item, text)
      next
    end
    if retweet_antibayesian_filter.call(item, text)
      #text = raw_text.c(:info)
      #screen_name_display = "#{item["user"]["screen_name"].c(:info)}"
      next
    end

    ####
    # Change colors
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
