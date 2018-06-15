# -*- encoding: utf-8 -*-
require 'find'

class Timer < Struct.new(:start_at)
  def self.start()
    Timer.new(Time.now())
  end

  def sleep_until(count)
    now = Time.now()
    sleep_sec = count - (now - start_at)
    if (sleep_sec <= 0.0)
      return
    end

    sleep(sleep_sec)
  end
end

SPEECH_TIMINGS = {
  5 => '15秒',
  10 => '10秒',
  15 => '5',
  16 => '4',
  17 => '3',
  18 => '2',
  19 => '1',
  20 => 'ハーフプランクスタート',
  25 => '15秒',
  30 => '10秒',
  35 => '5',
  36 => '4',
  37 => '3',
  38 => '2',
  39 => '1',
  40 => '休憩です',

  55 => '5',
  56 => '4',
  57 => '3',
  58 => '2',
  59 => '1',
  60 => 'ハーフプランクスタート',
  65 => '15秒',
  70 => '10秒',
  75 => '5',
  76 => '4',
  77 => '3',
  78 => '2',
  79 => '1',
  80 => 'そのまま左足を上げます',
  85 => '15秒',
  90 => '10秒',
  95 => '5',
  96 => '4',
  97 => '3',
  98 => '2',
  99 => '1',
  100 => '休憩です',

  115 => '5',
  116 => '4',
  117 => '3',
  118 => '2',
  119 => '1',
  120 => 'ハーフプランクスタート',
  125 => '15秒',
  130 => '10秒',
  135 => '5',
  136 => '4',
  137 => '3',
  138 => '2',
  139 => '1',
  140 => 'そのまま右足を上げます',
  145 => '15秒',
  150 => '10秒',
  155 => '5',
  156 => '4',
  157 => '3',
  158 => '2',
  159 => '1',
  160 => '休憩です',

  175 => '5',
  176 => '4',
  177 => '3',
  178 => '2',
  179 => '1',
  180 => 'ハーフプランクスタート',
  185 => '15秒',
  190 => '10秒',
  195 => '5',
  196 => '4',
  197 => '3',
  198 => '2',
  199 => '1',
  200 => 'レフトサイドプランクスタート',
  205 => '15秒',
  210 => '10秒',
  215 => '5',
  216 => '4',
  217 => '3',
  218 => '2',
  219 => '1',
  220 => '休憩です',

  235 => '5',
  236 => '4',
  237 => '3',
  238 => '2',
  239 => '1',
  240 => 'ハーフプランクスタート',
  245 => '15秒',
  250 => '10秒',
  255 => '5',
  256 => '4',
  257 => '3',
  258 => '2',
  259 => '1',
  260 => 'ライトサイドプランクスタート',
  265 => '15秒',
  270 => '10秒',
  275 => '5',
  276 => '4',
  277 => '3',
  278 => '2',
  279 => '1',
  280 => '休憩です',

  295 => '5',
  296 => '4',
  297 => '3',
  298 => '2',
  299 => '1',
  300 => 'リバースハーフプランクスタート',
  305 => '15秒',
  310 => '10秒',
  315 => '5',
  316 => '4',
  317 => '3',
  318 => '2',
  319 => '1',
  320 => 'リバースフルプランクスタート',
  325 => '15秒',
  330 => '10秒',
  335 => '5',
  336 => '4',
  337 => '3',
  338 => '2',
  339 => '1',
  340 => 'トレーニング終了です。お疲れ様でした。',
}

REG_AUDIO_EXT = %r!\.(mp3|wav)$!
def load_yells
  out = []
  Find.find("yell") do |file|
    out.push(file) if REG_AUDIO_EXT =~ file
  end
  out
end

def main
  yells = load_yells
  say('プランクトレーニングをはじめます')

  sleep(3)

  pre_timer = Timer.start
  say('5')
  pre_timer.sleep_until(1)
  say('4')
  pre_timer.sleep_until(2)
  say('3')
  pre_timer.sleep_until(3)
  say('2')
  pre_timer.sleep_until(4)
  say('1')
  pre_timer.sleep_until(5)

  last_yelled_at = nil
  timer = Timer.start
  say('フルプランク スタート')
  (1..345).each {|i|
    timer.sleep_until(i)
    speech = SPEECH_TIMINGS[i]
    if (speech)
      say(speech)
    end

    if yells.size > 0 && (!last_yelled_at || last_yelled_at < i - 2) && rand(3) == 0
      yell(yells.shuffle.first)
      last_yelled_at = i
    end
  }
end

def say(word)
  Thread.new {
    puts(word)
    system('say', word)
  }.run
end

def yell(file)
  if File.exists?(file)
    Thread.new {
      system('afplay', '-v', '0.5', file)
    }.run
  end
end

case $PROGRAM_NAME
when __FILE__
  main
when /spec[^\/]*$/
  # {spec of the implementation}
end

